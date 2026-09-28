open System
open System.IO

let help_menu() =
    printfn "efc version 0.0.1 Usage: ./efc hi.efc"

[<EntryPoint>]
let main argv =
    if argv.Length = 1 then
        let file: string[] = File.ReadAllLines(argv.[0])
        for line in file do
            printfn "%s" line
    else help_menu()
    0