let
    output = (color as text, optional direction as nullable number) =>
        let
            dr = if direction = null then 0 else direction,
            dirList = {0, 1},
            act =
                try
                    let
                        clearedColor = Text.Replace(Text.Upper(Text.Remove(color, {"#", "(", ")"})), "RGB", ""),
                        hexList = {"A", "B", "C", "D", "E", "F"},
                        dir = dirList{List.PositionOf(dirList, dr)},
                        typeOfCalculation =
                            if dr = 0 then
                                let
                                    colorModifier = (hexColorValue as number) =>
                                        let
                                            firstPosition = Number.Mod(hexColorValue, 16),
                                            decreaser = Number.IntegerDivide(hexColorValue, 16),
                                            zeroPosition = Number.Mod(decreaser, 16),
                                            replacer = List.Transform(
                                                {zeroPosition, firstPosition},
                                                each if _ > 9 then hexList{(Number.Mod(_, 9) - 1)} else Text.From(_)
                                            )
                                        in
                                            Text.Combine(replacer, ""),
                                    listSeparator = Text.Split(clearedColor, ","),
                                    transformator = List.Transform(listSeparator, each colorModifier(Number.From(_)))
                                in
                                    "#" & Text.Combine(transformator, "")
                            else
                                let
                                    colorModifier = (decimalColorValue as text) =>
                                        let
                                            split = Splitter.SplitTextByPositions({0, 1})(decimalColorValue),
                                            modifyContent = List.Transform(
                                                split,
                                                each
                                                    let
                                                        vl = _, p = List.PositionOf(hexList, _)
                                                    in
                                                        if p < 0 then
                                                            Number.From(vl)
                                                        else
                                                            p + 10
                                            ),
                                            out = modifyContent{0} * 16 + modifyContent{1}
                                        in
                                            Text.From(out),
                                    listSeparator = Splitter.SplitTextByPositions({0, 2, 4})(clearedColor),
                                    transformator = List.Transform(listSeparator, each colorModifier(_))
                                in
                                    "RGB(" & Text.Combine(transformator, ",") & ")"
                    in
                        typeOfCalculation
                    catch (r) =>
                        if r[Message] = "We couldn't convert to Number." then
                            error
                                [
                                    Message = "Please make sure, that you are inserting correct color type based on your selection in second parameter of this fucntion!"
                                ]
                        else
                            error [Message = "Please insert only these values {0,1} -> 0 = RGB2HEX or 1 = HEX2RGB"]
        in
            act,
    documentation = [
        Documentation.Name = " get-ConverterBetweenHEXandRGB.pq ",
        Documentation.Description = " Converts RGB color code to HEX code and VICE VERSA. Native direction is from RGB to HEX, opposite direction is settable by second parameter of this function. This function can work with standart declaration of these color codes like: ""RGB(.,.,.)"" or ""#FFFFFF"". Accepted enumerations: 0 = RGB2HEX, 1 = HEX2RGB ",
        Documentation.Source = "https://www.datameerkat.com ",
        Documentation.Version = " 1.0 ",
        Documentation.Author = " Štěpán Rešl ",
        Documentation.Examples = {
            [
                Description = " Convert from HEX to RGB *doesnt require second parameter* ",
                Code = " #""get-ConverterBetweenHEXandRGB""(""RGB(123,10,50)"") ",
                Result = "#7B0A32"
            ],
            [
                Description = " Convert from HEX to RGB ",
                Code = " #""get-ConverterBetweenHEXandRGB""(""#7B0A32"",1) ",
                Result = "RGB(123,10,50)"
            ]
        }
    ]
in
    Value.ReplaceType(output, Value.ReplaceMetadata(Value.Type(output), documentation))
