param(
    [string]$OutFile = "data/memory_rss.txt",
    [int]$IntervalSeconds = 15
)
$deadline = (Get-Date).AddHours(24)
while ((Get-Date) -lt $deadline) {
    $procs = Get-Process dd, dreamdaemon -ErrorAction SilentlyContinue
    if (-not $procs) { break }
    try {
        ($procs | Measure-Object WorkingSet64 -Sum).Sum | Out-File -FilePath $OutFile -Encoding ascii -Force
    } catch {} # file briefly locked by the game reading it, skip this sample
    Start-Sleep -Seconds $IntervalSeconds
}
