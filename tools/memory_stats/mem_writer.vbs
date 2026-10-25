'' Launches mem_writer.ps1 without opening a console window
CreateObject("WScript.Shell").Run "powershell -NoProfile -ExecutionPolicy Bypass -File ""tools\memory_stats\mem_writer.ps1""", 0, False
