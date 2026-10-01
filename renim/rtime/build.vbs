WScript.Echo "*warling: before build, remove `rtime.dll` in this current folder. if you don't, Builder think work finished."
WScript.Echo "Go to https://evrlang.github.io/errors/rtime-builder/errors.html to learn more about errors."

Dim b
Set b = CreateObject("WScript.Shell")
b.Run "gcc -O2 -Wall -shared rtime.c -o rtime.dll -Wl,--out-implib,librtime.a -lkernel32", 1, True
Dim c
Set c = CreateObject("Scripting.FileSystemObject")
If c.FileExists("rtime.dll") Then
    b.Run "dlltool -d rtime.def -l rtime.lib -D rtime.dll", 1, True
    if c.FileExists("rtime.lib") Then
        WScript.Echo "(1) Build Done."
    else 
        WScript.Echo "(1) EC:3101 - Build Failed."
    End If
else 
    WScript.Echo "(1) EC:3102 - Build Failed."
End If