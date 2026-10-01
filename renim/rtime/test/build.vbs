Dim a, b 
Set a = CreateObject("WScript.Shell")
a.Run "nasm -f win64 test.asm -o test.obj", 0, True
a.Run "lld-link test.obj ""C:\Program Files\Microsoft SDKs\Windows\v7.1\Lib\x64\Kernel32.lib"" rtime.lib -entry:main -subsystem:console -out:test.exe", 0, True