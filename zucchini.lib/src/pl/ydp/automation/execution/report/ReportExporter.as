package pl.ydp.automation.execution.report
{
	import org.osflash.signals.Signal;
	import org.robotlegs.core.IInjector;

	public class ReportExporter
	{
		[Inject]
		public var reportModel:ReportModel
		[Inject]
		public var injector:IInjector;
		
		private var _reportExported:Signal = new Signal();
		
		public function ReportExporter()
		{
		}
		
		
		/**
		 * Przechwycenie modelu danych wykonanego skryptu (feature).
		 */
		public function handleReportData( reportData:ReportData ):void
		{
			if( reportModel.instantExport ){
				exportReport( reportData );
			}else{
				reportModel.addReportData( reportData );
			}
			
		}
		
		
		
		
		/**
		 * Eksport wszystkich raportów z modelu do odpowiednich formatów.
		 */
		public function exportReports():void
		{
			if( !reportModel.instantExport ){
				for each( var reportData:ReportData in reportModel.reportsData ){
					
					exportReport( reportData );
				}
			}
		}
		
		/**
		 * Export raportu do odpowiednich formatów.
		 */
		internal function exportReport( reportData:ReportData ):void
		{
			for each( var reportFormatter:IReportFormatter in reportModel.reportsFormatters ){
				var report:String = reportFormatter.format( reportData );
				
				for each( var target:IReportTarget in reportModel.reportsTargets ){
					injector.injectInto( target );
					target.send( reportData.reportXML.@name, report ).addOnce( onReportSent );
				}
				
			}
		}
		
		public function onReportSent():void
		{
			_reportExported.dispatch();
		}
		

		public function get reportExported():Signal
		{
			return _reportExported;
		}
		
		
		
	}
}