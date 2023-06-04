let
    output = (color as text, tintFactor) as text =>
        let
            colorList = Text.Split(color, ","),
            transformator = List.Transform(
                colorList,
                each let nm = Number.From(_) in Text.From(
                    Number.Round(nm + (Value.Multiply((255 - nm), tintFactor)), 0)
                )
            )
        in
            Text.Combine(transformator, ","),
    documentation = [
        Documentation.Name = " get-rgbTintModifier.pq ",
        Documentation.Description = " Insert your RGB color and TINT% and you will recieve modified RGB. ",
        Documentation.Source = "https://www.datameerkat.com",
        Documentation.Version = " 1.0 ",
        Documentation.Author = " Štěpán Rešl ",
        Documentation.Examples = {
            [
                Description = " Inserted RGB color: R: 68, G: 114, B: 196 and TINT 60% as a number",
                Code = " #""get-rgbTintModifier(""68,114,196"",0.6)"" ",
                Result = " 180,199,231 "
            ]
        }
    ]
in
    Value.ReplaceType(output, Value.ReplaceMetadata(Value.Type(output), documentation))
