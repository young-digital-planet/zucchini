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
		
		
		public function get reportXML():XML
		{
			return _reportXML;
		}

	}
}