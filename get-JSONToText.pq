let
    output = (jsonBinary as binary) as text =>
        let
            jsonBinaryText = Text.FromBinary(jsonBinary),
            hexList = {"A", "B", "C", "D", "E", "F"},
            composer = Text.Combine(
                List.Transform(
                    Text.Split(jsonBinaryText, "\u0"),
                    (inputTextPart) =>
                        if List.Contains({"{", "["}, Text.Start(inputTextPart, 1)) then
                            inputTextPart
                        else
                            [
                                init = Text.Start(inputTextPart, 3),
                                vls = List.Buffer(
                                    List.Transform(
                                        Text.ToList(init),
                                        (character) =>
                                            try
                                                Number.From(character)
                                            otherwise
                                                List.PositionOf(hexList, Text.Upper(character)) + 10
                                    )
                                ),
                                converted = Character.FromNumber(
                                    List.Sum(
                                        List.Generate(
                                            () => [result = vls{0} * Number.Power(16, 3 - 1), actual = 1],
                                            each [actual] <= 3,
                                            each
                                                [
                                                    result = vls{[actual]} * Number.Power(16, 3 - ([actual] + 1)),
                                                    actual = [actual] + 1
                                                ],
                                            each [result]
                                        )
                                    )
                                ),
                                result = Text.ReplaceRange(inputTextPart, 0, 3, converted)
                            ][result]
                )
            )
        in
            composer,
    documentation = [
        Documentation.Name = " get-JSONToText.pq ",
        Documentation.Description = " The function converts JSON Binary to TEXT by converting special leptin letters like č, ě, á, into their normal state. Otherwise, you can use Text.FromBinary() that will show that these letters are coded, for example, as \u011b. ",
        Documentation.Source = " https://www.datameerkat.com ",
        Documentation.Version = " 1.0 ",
        Documentation.Author = " Štěpán Rešl ",
        Documentation.Examples = {
            [
                Description = "Direct binary convert",
                Code = "get-JSONToText(jsonBinary)",
                Result = "{""A"":[1,true,""3""],""B"":""++ěščřžýáíéůa""}"
            ],
            [
                Description = "With covertion from M Record",
                Code = "get-JSONToText(Json.FromValue([A = {1, true, ""3""}, B = ""++ěščřžýáíéůa""]))",
                Result = "{""A"":[1,true,""3""],""B"":""++ěščřžýáíéůa""}"
            ]
        }
    ]
in
    Value.ReplaceType(output, Value.ReplaceMetadata(Value.Type(output), documentation))
