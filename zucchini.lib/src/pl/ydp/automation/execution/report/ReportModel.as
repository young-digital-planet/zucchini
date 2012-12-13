package pl.ydp.automation.execution.report
{
	public class ReportModel
	{
		private var _instantExport:Boolean;
		
		private var _reportsData:Array = [];
		
		private var _reportsTargets:Array;
		
		private var _reportsFormatters:Array;
		
		public function ReportModel()
		{
			
		}
		
		
		public function addReportData( report:ReportData ):void
		{
			_reportsData.push( report );
		}

		
		public function get reportsData():Array
		{
			return _reportsData;
		}

		public function get reportsTargets():Array
		{
			return _reportsTargets;
		}

		public function set reportsTargets(value:Array):void
		{
			_reportsTargets = value;
		}

		public function get instantExport():Boolean
		{
			return _instantExport;
		}

		public function set instantExport(value:Boolean):void
		{
			_instantExport = value;
		}

		public function get reportsFormatters():Array
		{
			return _reportsFormatters;
		}

		public function set reportsFormatters(value:Array):void
		{
			_reportsFormatters = value;
		}

		
	}
}