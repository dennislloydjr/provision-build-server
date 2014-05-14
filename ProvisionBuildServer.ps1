. .\DecryptPropertiesUtil.ps1

function Install-Prereqs {
	scoop install wget --global
	scoop install perl --global
	scoop install git --global
	scoop install java7 --global
}

function Install-Mysql {
	scoop install mysql --global
	$MySqlHome = $env:MYSQL_HOME
	$MySqlData = Join-Path (Get-DataPath) "mysql"
	$MySqlIniFile = Join-Path $MySqlHome "my.ini.2"
	@"
basedir=$MySqlHome
datadir=$MySqlData
	"@ | Out-File -FilePath $MySqlIniFile -Force
}

function Install-Stash {
	scoop install atlassian-stash --global
	$StashHomePath = Join-Path (Get-DataPath) "Stash"
	New-Path $StashHomePath > $null
	[System.Environment]::SetEnvironmentVariable("STASH_HOME", $StashHomePath, "User")
}

Install-Prereqs
Install-Mysql
# Install-Stash
