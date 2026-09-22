
Dim Tk
Set Tk = CreateObject("Scripting.Dictionary")

Sub Tokenlizer(lineh)
    
     ' Mid -> for get a vhar from position in string
     ' Len -> get string lenght

    Dim i, char
    Dim isQ
    isQ = False
    Dim Current
    For i = 1 To Len(lineh)
        char = Mid(lineh, i)
        If char = """" Then ' if(char == "\"")
            isQ = Not isQ
            Tk.Add i, Current, 1
            Current = ""
        ElseIf isQ = True Then
            Current = Current & char
        ElseIf isQ = False And char = " " Then
            Tk.Add i, Current, 1
            Current = ""
        Else 
            Current = Current & char
        End If
    Next

End Sub
