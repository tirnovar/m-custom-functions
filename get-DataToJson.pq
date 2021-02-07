let
    output =
        (toTable as table) as text =>
            let
                #"Run R script" =
                    R.Execute(
                        "# 'dataset' holds the input data for this script#(lf)library(jsonlite)#(lf)df <- data.frame(toString(toJSON(dataset)))",
                        [dataset = toTable]
                    ),
                #"""df""" = #"Run R script"{[Name = "df"]}[Value]
            in
                #"""df"""{0}[#"toString.toJSON.dataset.."],
    documentation = [
        Documentation.Name = " get-DataToJson.pq ",
        Documentation.Description = " Trasform full table into one JSON as Text ",
        Documentation.Source = "https://www.jaknapowerbi.cz . ",
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