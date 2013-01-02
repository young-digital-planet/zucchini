package pl.ydp.automation.configuration.settings
{
	import org.hamcrest.collection.array;

	/**
	 * API ustawień, które mogą być określane w runtime'ie 
	 * (również po startowej konfiguracji aplikacji).
	 */
	public interface ISettings
	{
		/**
		 * Lista nazw skryptów do przygotowania (załadowanie, sparsowanie, zmapowanie).
		 */
		function get scriptsToPrepareNames():Array;
		/**
		 * Lista nazw skryptów do wykonania.
		 */
		function get scriptsToExecuteNames():Array;
		/**
		 * Lista obiektów implementujących punkt docelowy raportu (IReportTarget).
		 */
		function get reportsTargets():Array;
		/**
		 * Lista obiektów implementujących formatowanie raportu (IReportFormatter).
		 */
		function get reportsFormatters():Array;
		/**
		 * Tryb wykonywania snapshotów ekranów (-> SnapshotModel.snapshotMode).
		 */ 
		function get snapshotMode():String;
		/**
		 * Środowisko wykonania testów (-> ExecutionModel.executionWrapper).
		 */
		function get executionWrapper():String;
		/**
		 * Interwał między wykionaniem poszczególnych kroków (w milisekundach).
		 */
		function get stepsInterval():int;
	}
}