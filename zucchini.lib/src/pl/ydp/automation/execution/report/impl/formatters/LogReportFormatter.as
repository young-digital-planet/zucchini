package pl.ydp.automation.execution.report.impl.formatters
{
	import pl.ydp.automation.execution.report.IReportFormatter;
	import pl.ydp.automation.execution.report.ReportData;
	import pl.ydp.automation.execution.report.ReportDataFactory;
	
	public class LogReportFormatter implements IReportFormatter
	{
		public function LogReportFormatter()
		{
		}
		
		public function format(reportData:ReportData):String
		{
			var reportStr:String = '';
			
			reportStr += '\n-----REPORT START-----\n';
			
			for each( var suiteXML:XML in  reportData.reportXML.testsuite ){
				reportStr += suiteToString( suiteXML );
			}
			reportStr += '\n-----REPORT END-----\n';
			
			return reportStr;
		}
		
		
		private function suiteToString( suiteXML:XML ):String
		{
			var suiteStr:String = '';
			suiteStr += getSuiteLine( suiteXML );
			
			for each( var caseXML:XML in suiteXML.testcase ){
				suiteStr += caseToString( caseXML );
			}
			
			return suiteStr;
		}
		
		private function caseToString( caseXML:XML ):String
		{
			var caseStr:String = '';
			var statusStr:String;
			var failureMessage:String = '';
			if( caseFailed( caseXML ) ){
				statusStr = 'FAILED';
				failureMessage = getFailureMessageFromCase( caseXML );
			}else{
				statusStr = 'OK';
			}
			caseStr += getCaseLine( caseXML, statusStr );
			
			for each( var stepXML:XML in caseXML.teststep ){
				caseStr += stepToString( stepXML, failureMessage );
			}
			
			return caseStr;
		}
		
		private function stepToString( stepXML:XML, failureMessage:String = null ):String
		{
			var stepStr:String = '';
			var statusStr:String;
			if( stepFailed( stepXML ) ){
				statusStr = 'FAILED (' + failureMessage + ')';
			}else{
				statusStr = 'OK';
			}
			stepStr += getStepLine( stepXML, statusStr );
			
			return stepStr;
		}
		
		
		private function getSuiteLine( suiteXML:XML ):String
		{
			return '\n' + 'SUITE:\n';
		}
		
		private function getCaseLine( caseXML:XML, statusStr:String ):String
		{
			return '\t' + statusStr + ' - ' + 'CASE: ' + caseXML.@name + '\n';
		}
		
		private function getStepLine( stepXML:XML, statusStr:String ):String
		{
			return '\t\t' + statusStr + ' - ' +  'STEP: ' + stepXML.@name + ' - ' + stepXML.@time + ' ms\n';
		}
		
		
		private function getFailureMessageFromCase( caseXML:XML ):String
		{
			var failureXML:XMLList = caseXML.failure;
			var message:String = failureXML[0].@message;
			return message;
		}
		
		
		private function caseFailed( caseXML:XML ):Boolean
		{
			var failureXML:XMLList = caseXML.failure;
			return failureXML.length() > 0;
		}
		
		private function stepFailed( stepXML:XML ):Boolean
		{
			return stepXML.@status == ReportDataFactory.STATUS_FAILED;
		}
		
	}
}