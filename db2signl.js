// SIGNL4 team URL (Replace <team-secret> by your SIGNL4 team secret)
var STRING_SIGNL4_URL 	= "https://account.signl4.com/webhook/<team-secret>";

// Thresholds (time in minutes, temperature in Celsius degrees)
var INT_TIME          = 10;
var INT_TEMPERATURE   = 40;

var oDb = new ActiveXObject("ADODB.Connection");
oDb.Open("Driver=SQL Server Native Client 11.0;Server=.\\sqlexpress;Trusted_Connection=Yes;Database=signl4");

// SQL
var sSql = "SELECT CONCAT('Temparature Alert on ', [MachineName]) AS 'Subject', [MachineName] AS 'Machine', MAX(Temperature) AS 'Temperature' FROM MachineData WHERE Timestamp > DATEADD(MINUTE, -" + INT_TIME + ", SYSDATETIME()) AND Temperature > " + INT_TEMPERATURE + " GROUP BY [MachineName]";

// Fetch data from DB
var oRes = oDb.Execute(sSql);

while (!oRes.EOF) {
	var sSubject 		= oRes.Fields.Item('Subject').Value;
	var sMachine 		= oRes.Fields.Item('Machine').Value;
	var iTemperature 	= oRes.Fields.Item('Temperature').Value;
	var sData			= '{ "Subject": "' + sSubject + '", "Machine": "' + sMachine + '", "Temperature": "' + iTemperature + '" }';
	
	triggerSignl(sData);
	
	oRes.MoveNext();
}

oDb.Close();

function triggerSignl(sData) {
	var oXhr = new ActiveXObject("Microsoft.XMLHTTP")
	oXhr.onreadystatechange = function() {
		if (oXhr.readyState == 4) {
			WScript.Echo(oXhr.responseText);
		}
	}
	oXhr.open("POST", STRING_SIGNL4_URL);
	oXhr.setRequestHeader("Content-Type", "application/json");
	
	// SIGNL4 call
	oXhr.send(sData);
	
	WScript.Echo(sData);
}
