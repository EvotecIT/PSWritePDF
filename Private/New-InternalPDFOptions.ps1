function New-InternalPDFOptions {
    param(
        $Settings
    )
    if ($Settings.Margins) {
        if ($Settings.Margins.Left) {
            $Script:Document.SetLeftMargin($Settings.Margins.Left)
        }
        if ($Settings.Margins.Right) {
            $Script:Document.SetRightMargin($Settings.Margins.Right)
        }
        if ($Settings.Margins.Top) {
            $Script:Document.SetTopMargin($Settings.Margins.Top)
        }
        if ($Settings.Margins.Bottom) {
            $Script:Document.SetBottomMargin($Settings.Margins.Bottom)
        }
    }
}