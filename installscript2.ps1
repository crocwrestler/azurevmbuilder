# Install Azure CLI
$ProgressPreference = 'SilentlyContinue'; Invoke-WebRequest -Uri https://aka.ms/installazurecliwindows -OutFile .\AzureCLI.msi; Start-Process msiexec.exe -Wait -ArgumentList '/I AzureCLI.msi /qn'
#Install Podman

#Install AZCopy
$dlUrl = "https://aka.ms/downloadazcopy-v10-windows"
$zipFile = "azcopy.zip"
$extractPath = "C:\Program Files\Microsoft\AzCopy"
Invoke-WebRequest -Uri $dlUrl -OutFile $zipFile
Expand-Archive -Path $zipFile -DestinationPath $extractPath -Force
$azcopyPath = (Get-ChildItem -Path $extractPath -Recurse -Filter "azcopy.exe").FullName
[Environment]::SetEnvironmentVariable("Path", $env:Path + ";$extractPath", [EnvironmentVariableTarget]::Machine)
Remove-Item $zipFile


#Install Docker


Invoke-WebRequest -UseBasicParsing "https://raw.githubusercontent.com/microsoft/Windows-Containers/Main/helpful_tools/Install-DockerCE/install-docker-ce.ps1" -OutFile "install-docker-ce.ps1"; & ".\install-docker-ce.ps1"

#Install Podman

$repo = "containers/podman"
$asset = (Invoke-RestMethod -Uri "https://api.github.com/repos/$repo/releases/latest").assets | Where-Object name -like "*podman-*-setup.exe"
$url = $asset.browser_download_url
$outFile = "podman-setup.exe"
Invoke-WebRequest -Uri $url -OutFile $outFile
Start-Process -FilePath $outFile -ArgumentList "/S" -Wait -NoNewWindow
Remove-Item $outFile

