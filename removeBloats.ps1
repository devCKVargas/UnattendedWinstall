# List of bloatwares to remove except those that start with a '#'
$bloatApps = @(
	'Microsoft.Microsoft3DViewer';
	'Microsoft.BingSearch';
	# 'Microsoft.WindowsCalculator';
	'Microsoft.WindowsCamera';
	'Clipchamp.Clipchamp';
	'Microsoft.WindowsAlarms';
	'Microsoft.549981C3F5F10';
	'Microsoft.Windows.DevHome';
	'MicrosoftCorporationII.MicrosoftFamily';
	'Microsoft.WindowsFeedbackHub';
	'Microsoft.GetHelp';
	'microsoft.windowscommunicationsapps';
	'Microsoft.WindowsMaps';
	'Microsoft.ZuneVideo';
	'Microsoft.BingNews';
	'Microsoft.WindowsNotepad';
	'Microsoft.MicrosoftOfficeHub';
	'Microsoft.Office.OneNote';
	'Microsoft.OutlookForWindows';
	'Microsoft.Paint';
	'Microsoft.MSPaint';
	'Microsoft.People';
	# 'Microsoft.Windows.Photos';
	'Microsoft.PowerAutomateDesktop';
	'MicrosoftCorporationII.QuickAssist';
	'Microsoft.SkypeApp';
	'Microsoft.ScreenSketch';
	'Microsoft.MicrosoftSolitaireCollection';
	'Microsoft.MicrosoftStickyNotes';
	'MSTeams';
	'Microsoft.Getstarted';
	'Microsoft.Todos';
	'Microsoft.WindowsSoundRecorder';
	'Microsoft.BingWeather';
	'Microsoft.ZuneMusic';
	# 'Microsoft.WindowsTerminal';
	'Microsoft.Xbox.TCUI';
	# 'Microsoft.XboxApp';
	'Microsoft.XboxGameOverlay';
	'Microsoft.XboxGamingOverlay';
	# 'Microsoft.XboxIdentityProvider';
	'Microsoft.XboxSpeechToTextOverlay';
	'Microsoft.GamingApp';
	'Microsoft.YourPhone';
	# 'Microsoft.MicrosoftEdge';
	# 'Microsoft.MicrosoftEdge.Stable';
	'Microsoft.MicrosoftEdge_8wekyb3d8bbwe';
	'Microsoft.MicrosoftEdgeDevToolsClient_8wekyb3d8bbwe';
	'Microsoft.MicrosoftEdgeDevToolsClient_1000.19041.1023.0_neutral_neutral_8wekyb3d8bbwe';
	'Microsoft.MicrosoftEdge_44.19041.1266.0_neutral__8wekyb3d8bbwe';
	'Microsoft.OneDrive';
	# 'Microsoft.MicrosoftEdgeDevToolsClient';
	'Microsoft.549981C3F5F10';
	'Microsoft.MixedReality.Portal';
	'Microsoft.Windows.Ai.Copilot.Provider';
	'Microsoft.WindowsMeetNow';
	# 'Microsoft.WindowsStore';
	'Microsoft.Wallet';
)

function Remove-Bloatware {
	$bloatApps | ForEach-Object {
		try {
			Write-Host "Attempting to remove $_..."
			(Get-AppxProvisionedPackage -Online | Where-Object DisplayName -EQ $_ | Remove-AppxProvisionedPackage -AllUsers -Online) *>> "$env:USERPROFILE\Desktop\remove-bloatware-logs.log"
			Write-Host "Removed: $_." -ForegroundColor Green
		}
		catch {
			Write-Host "Failed: $_" -ForegroundColor Red
		}
	}
}

# Check if running as administrator
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
	Write-Host "Requesting administrative privileges..."
	if (Get-Command pwsh -ErrorAction SilentlyContinue) {
		Start-Process pwsh -Verb RunAs -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`""
	}
 else {
		Start-Process powershell -Verb RunAs -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`""
	}
	exit
}

# Run the Remove-Bloatware function
# If (Get-Command gsudo -ErrorAction SilentlyContinue) {
# 	gsudo { Remove-Bloatware }
# } 
# else { Remove-Bloatware }

Remove-Bloatware 

Write-Host "Operation completed. Check the log file for details." -ForegroundColor Blue
