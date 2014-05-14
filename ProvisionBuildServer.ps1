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
	$MySqlData = Join-Path ($env:DATA_PATH) "mysql"
	$MySqlIniFile = Join-Path $MySqlHome "my.ini.2"
	@"
[mysqld]
basedir=$MySqlHome
datadir=$MySqlData
port=3306
default-storage-engine=InnoDB
"@ | Out-File -FilePath $MySqlIniFile -Force

	mysqld --install MySQL --defaults-file="$MySqlIniFile"
	net start MySQL
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
