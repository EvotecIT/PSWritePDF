using System;
using System.Collections.Concurrent;
using System.Management.Automation;
using System.Threading;
using System.Threading.Tasks;

namespace PSWritePDF;
/// <summary>
/// Base class for asynchronous PowerShell cmdlets.
/// </summary>
public abstract class AsyncPSCmdlet : PSCmdlet, IDisposable {
    /// <summary>
    /// Types of pipeline messages handled by <see cref="AsyncPSCmdlet"/>.
    /// </summary>
    private enum PipelineType {
        Output,
        OutputEnumerate,
        Error,
        Warning,
        Verbose,
        Debug,
        Information,
        Progress,
    }

    private CancellationTokenSource _cancelSource = new();

    private BlockingCollection<(object?, PipelineType)>? _currentPipe;

    /// <summary>
    /// Gets the cancellation token for the cmdlet execution.
    /// </summary>
    protected CancellationToken CancelToken { get => _cancelSource.Token; }

    /// <summary>
    /// Invoked when the cmdlet begins execution.
    /// Runs <see cref="BeginProcessingAsync"/> within the asynchronous pipeline.
    /// </summary>
    protected override void BeginProcessing()
        => RunBlockInAsync(BeginProcessingAsync);

    /// <summary>
    /// Performs initialization logic for the cmdlet.
    /// </summary>
    /// <returns>A <see cref="System.Threading.Tasks.Task"/> representing the asynchronous operation.</returns>
    protected virtual Task BeginProcessingAsync()
        => Task.CompletedTask;

    /// <summary>
    /// Processes input records synchronously and dispatches <see cref="ProcessRecordAsync"/>.
    /// </summary>
    protected override void ProcessRecord()
        => RunBlockInAsync(ProcessRecordAsync);

    /// <summary>
    /// Executes the main cmdlet logic.
    /// </summary>
    /// <returns>A <see cref="System.Threading.Tasks.Task"/> representing the asynchronous operation.</returns>
    protected virtual Task ProcessRecordAsync()
        => Task.CompletedTask;

    /// <summary>
    /// Invoked once when processing has completed.
    /// Runs <see cref="EndProcessingAsync"/> within the asynchronous pipeline.
    /// </summary>
    protected override void EndProcessing()
        => RunBlockInAsync(EndProcessingAsync);

    /// <summary>
    /// Performs cleanup logic for the cmdlet.
    /// </summary>
    /// <returns>A <see cref="System.Threading.Tasks.Task"/> representing the asynchronous operation.</returns>
    protected virtual Task EndProcessingAsync()
        => Task.CompletedTask;

    /// <summary>
    /// Requests cancellation of the cmdlet execution.
    /// </summary>
    protected override void StopProcessing()
        => _cancelSource?.Cancel();

    private void RunBlockInAsync(Func<Task> task) {
        using BlockingCollection<(object?, PipelineType)> pipe = new();
        Task blockTask = Task.Run(async () => {
            try {
                _currentPipe = pipe;
                await task();
            } finally {
                _currentPipe = null;
                pipe.CompleteAdding();
            }
        });

        foreach ((object? data, PipelineType pipelineType) in pipe.GetConsumingEnumerable()) {
            switch (pipelineType) {
                case PipelineType.Output:
                    base.WriteObject(data);
                    break;

                case PipelineType.OutputEnumerate:
                    base.WriteObject(data, true);
                    break;

                case PipelineType.Error:
                    base.WriteError((ErrorRecord)data!);
                    break;

                case PipelineType.Warning:
                    base.WriteWarning((string)data!);
                    break;

                case PipelineType.Verbose:
                    base.WriteVerbose((string)data!);
                    break;

                case PipelineType.Debug:
                    base.WriteDebug((string)data!);
                    break;

                case PipelineType.Information:
                    base.WriteInformation((InformationRecord)data!);
                    break;

                case PipelineType.Progress:
                    base.WriteProgress((ProgressRecord)data!);
                    break;
            }
        }

        blockTask.GetAwaiter().GetResult();
    }

    /// <summary>
    /// Writes an object to the pipeline.
    /// </summary>
    /// <param name="sendToPipeline">Object to write.</param>
    public new void WriteObject(object? sendToPipeline) => WriteObject(sendToPipeline, false);

    /// <summary>
    /// Writes an object to the pipeline with optional enumeration.
    /// </summary>
    /// <param name="sendToPipeline">Object to write.</param>
    /// <param name="enumerateCollection">True to enumerate collections.</param>
    public new void WriteObject(object? sendToPipeline, bool enumerateCollection) {
        ThrowIfStopped();
        _currentPipe?.Add(
            (sendToPipeline, enumerateCollection ? PipelineType.OutputEnumerate : PipelineType.Output));
    }

    /// <summary>
    /// Writes an error record to the pipeline.
    /// </summary>
    /// <param name="errorRecord">The error record.</param>
    public new void WriteError(ErrorRecord errorRecord) {
        ThrowIfStopped();
        _currentPipe?.Add((errorRecord, PipelineType.Error));
    }

    /// <summary>
    /// Writes a warning message to the pipeline.
    /// </summary>
    /// <param name="message">The warning message.</param>
    public new void WriteWarning(string message) {
        ThrowIfStopped();
        _currentPipe?.Add((message, PipelineType.Warning));
    }

    /// <summary>
    /// Writes a verbose message to the pipeline.
    /// </summary>
    /// <param name="message">The verbose message.</param>
    public new void WriteVerbose(string message) {
        ThrowIfStopped();
        _currentPipe?.Add((message, PipelineType.Verbose));
    }

    /// <summary>
    /// Writes a debug message to the pipeline.
    /// </summary>
    /// <param name="message">The debug message.</param>
    public new void WriteDebug(string message) {
        ThrowIfStopped();
        _currentPipe?.Add((message, PipelineType.Debug));
    }

    /// <summary>
    /// Writes an information record to the pipeline.
    /// </summary>
    /// <param name="informationRecord">The information record.</param>
    public new void WriteInformation(InformationRecord informationRecord) {
        ThrowIfStopped();
        _currentPipe?.Add((informationRecord, PipelineType.Information));
    }

    /// <summary>
    /// Writes a progress record to the pipeline.
    /// </summary>
    /// <param name="progressRecord">The progress record.</param>
    public new void WriteProgress(ProgressRecord progressRecord) {
        ThrowIfStopped();
        _currentPipe?.Add((progressRecord, PipelineType.Progress));
    }

    /// <summary>
    /// Throws if the cmdlet execution has been stopped.
    /// </summary>
    internal void ThrowIfStopped() {
        if (_cancelSource.IsCancellationRequested) {
            throw new PipelineStoppedException();
        }
    }

    /// <summary>
    /// Disposes managed resources.
    /// </summary>
    public void Dispose() {
        _cancelSource?.Dispose();
    }
}