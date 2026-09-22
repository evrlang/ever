' (C) 2026 - EvrLang/ever. Copyright - Pouya Mohammadi
Dim version
version = "0.0.1" ' Interperter Version

Sub HelpMenu()
    WScript.Echo "EverStreamScript - A Ever interperter for Windows Computers."
    WScript.Echo "(C) 2026 - Pouya Mohammadi (poya1dev-github)" & vbNewLine & "Usage:"
    WScript.Echo vbTab & "ess [filename]"
    WScript.Echo version
End Sub

Sub LoadStdFuncs()
    Dim fs, fil, txt
    Set fs = CreateObject("Scripting.FileSystemObject")
    Set fil = fs.OpenTextFile("std\token.vbs")
    txt = fil.ReadAll()
    ExecuteGlobal txt
End Sub

Dim args
Set args = WScript.Arguments

If args.Count > 0 Then
    Dim fso
    Set fso = CreateObject("Scripting.FileSystemObject")
    If fso.FileExists(args(0)) Then 
        ' WScript.Echo "ITS A DEMO."
        Dim file 
        Set file = fso.OpenTextFile(args(0), 1)
        LoadStdFuncs
        Do Until file.AtEndOfStream
            Dim line 
            line = file.ReadLine
            Call Tokenlizer(line)
            Dim key
            For Each key In Tk.Keys
                WScript.Echo key & "=" & Tk(key)
            Next
        Loop
    Else 
        WScript.Echo "Error: File `" & args(0) & "` Not exists."
    End If
Else
    HelpMenu
End If