package pl.ydp.automation.execution.report
{
	/**
	 * Klasa będąca reprezentacją modelu danych 
	 * raportu dla pojedynczego skryptu (feature'a).
	 */
	public class ReportData
	{
		/**
		 * XML w formacie zgodnym z JUnitReport wzbogacony o węzły
		 * dla kroków (steps).
		 */
		private var _reportXML:XML;
		
		public function ReportData( xml:XML, scriptName:String )
		{
			_reportXML = xml;
			_reportXML.testsuite.@name = scriptName;
		}
		
		
		
		
//		REPORT INFO FIELDS
		
		public function set classname( value:String ):void
		{
			_reportXML.testsuite.@classname = value;
		}
		
		public function set file( value:String ):void
		{
			_reportXML.testsuite.@file = value;
		}
//		---
		
		
		
		public function get reportXML():XML
		{
			return _reportXML;
		}

	}
}