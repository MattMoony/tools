#SingleInstance, force

Explorer_GetSelection(hwnd="") {
    ; Credit:
    ; https://stackoverflow.com/questions/39253268/autohotkey-and-windows-10-how-to-get-current-explorer-path
    WinGet, process, processName, % "ahk_id" hwnd := hwnd? hwnd:WinExist("A")
    WinGetClass class, ahk_id %hwnd%
    if  (process = "explorer.exe") 
        if (class ~= "(Cabinet|Explore)WClass") {
            for window in ComObjCreate("Shell.Application").Windows
                if  (window.hwnd==hwnd)
                    path := window.Document.FocusedItem.path

            SplitPath, path,,dir
        }
        return dir
}

Start_WindowsTerminal() {
    Run, wt
    Sleep, 500
}

^!t::
currentPath := Explorer_GetSelection()
Start_WindowsTerminal()
Send, cd %currentPath%{Enter}
Send, clear{Enter}
return

^!+t::
currentPath := Explorer_GetSelection()
driveLetter := SubStr(currentPath, 1, 1)
currentPath := SubStr(currentPath, 4)
StringLower, driveLetter, driveLetter
currentPath = /mnt/%driveLetter%/%currentPath%
Loop {
    currentPath := StrReplace(currentPath, "\", "/", Count)
    if (Count = 0) 
        break
}
Start_WindowsTerminal()
Send, ^+3
Sleep, 100
Send, ^{Tab}
Send, ^w
Send, cd %currentPath%{Enter}
Send, clear{Enter}
return