^!k::
Tooltip, starting wt ...
Run, wt, , , wt_pid
WinActivate ahk_pid %wt_pid%
Sleep, 1000
Tooltip
Send, cd d:\school\SYP\3DHIF\KainPlan\website{enter}clear{enter}
Send, ^+3
Sleep, 300
Send, cd /mnt/d/school/SYP/3DHIF/KainPlan/website{enter}clear{enter}
Send, ^+1
Sleep, 300
Send, cd d:\school\SYP\3DHIF\KainPlan\api{enter}clear{enter}
Send, ^+3
Sleep, 300
Send, cd /mnt/d/school/SYP/3DHIF/KainPlan/api{enter}clear{enter}
Send, ^+1
Sleep, 300
Send, clear{enter}
Send, mysql -u root -p{enter}
return