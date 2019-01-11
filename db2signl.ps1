# SIGNL4 team URL (Replace <team-secret> by your SIGNL4 team secret)
$sSignl4Url = "https://account.signl4.com/webhook/<team-secret>"

# Thresholds (time in minutes, temperature in Celsius degrees)
$iTime = 10
$iTemperature = 40

# SQL
$sSql = "SELECT CONCAT('Temparature Alert on ', [MachineName]) AS 'Subject', [MachineName] AS 'Machine', MAX(Temperature) AS 'Temperature' FROM [signl4].[dbo].[MachineData] WHERE Timestamp > DATEADD(MINUTE, -" + $iTime + ", SYSDATETIME()) AND Temperature > " + $iTemperature + " GROUP BY [MachineName]"

# Fetch data from DB
$aData = Invoke-Sqlcmd -Query $sSql -ServerInstance "localhost\sqlexpress"

# invoke-sqlcmd -Query $sSql -ConnectionString "Driver=SQL Server Native Client 11.0;Server=sqlserver.derdack-support.local;Trusted_Connection=No;UID=sa;PWD=none;Database=EnterpriseAlert2017"

foreach ($aRes in $aData) {
	$parameters = '{ "Subject": "' + $aRes[0] + '", "Machine": "' + $aRes[1] + '", "Temperature": "' + $aRes[2] + '" }'

	echo $parameters

	# SIGNL4 call
	Invoke-RestMethod $sSignl4Url -Method POST -ContentType "application/json" -Body $parameters
}
