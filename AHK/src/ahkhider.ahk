/*
		hyde.dll hides a process from the Task-Manager on Windows2k/Windows7 (x86/x64 bit)!

		Your process can inject it into other processes however you like.  The example uses
		SetWindowsHookEx with a CBT hook (the dll  exports a CBTProc) to inject it into all
		running processes.

		Press Esc to exit the script.

		Note: if you do not compile the  script, AutoHotKey.exe gets hidden.  Otherwise the
		the name of the .exe gets hidden.

		Important: This does only work if you are using a x64 bit OS and the 64 bit version
		of AutoHotkey or if you're using a x86 bit OS and the 32 bit version of AutoHotkey.
		This does not work if you have a x64 bit OS but use 32 bit AHK (and vice versa) !!!
*/

#NoEnv
SetWorkingDir %A_ScriptDir%

OnExit, ExitSub

RunAsAdmin()

if ((A_Is64bitOS=1) && (A_PtrSize!=4))
	hMod := DllCall("LoadLibrary", Str, "hyde64.dll", Ptr)
else if ((A_Is32bitOS=1) && (A_PtrSize=4))
	hMod := DllCall("LoadLibrary", Str, "hyde.dll", Ptr)
Else
{
	MsgBox, Mixed Versions detected!`nOS Version and AHK Version need to be the same (x86 & AHK32 or x64 & AHK64).`n`nScript will now terminate!
	ExitApp
}

if (hMod)
{
	hHook := DllCall("SetWindowsHookEx", Int, 5, Ptr, DllCall("GetProcAddress", Ptr, hMod, AStr, "CBProc", ptr), Ptr, hMod, Ptr, 0, Ptr)
	if (!hHook)
	{
		MsgBox, SetWindowsHookEx failed!`nScript will now terminate!
		ExitApp
	}
}
else
{
	MsgBox, LoadLibrary failed!`nScript will now terminate!
	ExitApp
}

MsgBox, % "Process ('" . A_ScriptName . "') hidden!"
Return

End::ExitApp

RunAsAdmin()
{
	Global 0
	IfEqual, A_IsAdmin, 1, Return 0
	
	Loop, %0%
		params .= A_Space . %A_Index%
	
	DllCall("shell32\ShellExecute" (A_IsUnicode ? "":"A"),uint,0,str,"RunAs",str,(A_IsCompiled ? A_ScriptFullPath : A_AhkPath),str,(A_IsCompiled ? "": """" . A_ScriptFullPath . """" . A_Space) params,str,A_WorkingDir,int,1)
	ExitApp
}

ExitSub:
	if (hHook)
	{
		DllCall("UnhookWindowsHookEx", Ptr, hHook)
		MsgBox, % "Process unhooked!"
	}
	if (hMod)
	{
		DllCall("FreeLibrary", Ptr, hMod)
		MsgBox, % "Library unloaded"
	}
ExitApp
