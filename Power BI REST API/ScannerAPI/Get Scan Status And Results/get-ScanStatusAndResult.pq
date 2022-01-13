let
    output =
        (generatedToken as text, scanId as text) =>
            let
                status = get-ScanStatus(generatedToken, scanId),
                result = if status[status]{0} = "Succeeded" then get-ScanResult(generatedToken, scanId) else "Scan is still not finished. Please try again later."
            in
                result,
    documentation = [
        Documentation.Name = " get-ScanStatusAndResults.pq ",
        Documentation.Description = " This function returns the status of the scan and the results of the scan but only if scan has been Successful ",
        Documentation.Source = "https://www.jaknapowerbi.cz",
        Documentation.Version = " 1.0 ",
        Documentation.Author = " Štěpán Rešl "
    ]
in
    Value.ReplaceType(
        output,
        Value.ReplaceMetadata(
            Value.Type(output),
            documentation
        )
    )