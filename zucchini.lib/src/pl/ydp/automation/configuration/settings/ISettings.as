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
		 * Środowisko wykonania testów (-> EnvironmentModel.executionWrapper).
		 */
		function get executionWrapper():String;
		/**
		 * Interwał między wykonaniem poszczególnych kroków (w milisekundach).
		 */
		function get stepsInterval():int;
		/**
		 * Flaga określająca moment eksportu raportu feature'a.
		 * <code>true</code> - eksport raportów na koniec każdego feature'a
		 * <code>false</code> - eksport raportu po zakończeniu ostatniego feature'a
		 */
		function get instantExport():Boolean;
		/**
		 * Przekazanie flagi określającej sposób kontynuacji 
		 * wykonywania testów po case'ie, który zakończył się niepowodzeniem.
		 * <code>true</code> - case failed => suite (feature) failed - przejście do następnego suite'a
		 * <code>false</code> - case failed => przejście do następnego case'a
		 */
		function get stopOnFailure():Boolean;
	}
}