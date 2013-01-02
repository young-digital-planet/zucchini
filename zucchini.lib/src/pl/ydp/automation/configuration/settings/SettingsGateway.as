package pl.ydp.automation.configuration.settings
{
	import pl.ydp.automation.configuration.EnvironmentModel;
	import pl.ydp.automation.execution.ExecutionModel;
	import pl.ydp.automation.execution.report.ReportModel;
	import pl.ydp.automation.execution.storage.StorageModel;
	import pl.ydp.automation.execution.storage.snapshot.SnapshotsModel;
	import pl.ydp.automation.scripts.ScriptsModel;

	/**
	 * Klasa pośrednicząca we wtryskiwaniu ustawień modeli danych.
	 */
	public class SettingsGateway
	{
		[Inject]
		public var scriptsModel:ScriptsModel;
		[Inject]
		public var storageModel:StorageModel;
		[Inject]
		public var reportModel:ReportModel;
		[Inject]
		public var snapshotModel:SnapshotsModel;
		[Inject]
		public var environmentModel:EnvironmentModel;
		[Inject]
		public var executionModel:ExecutionModel;
		
		
		
		private var _settings:ISettings;
		
		private var _isPostConstruct:Boolean = false;
		
		public function SettingsGateway()
		{
			
		}
		
		
		[PostConstruct]
		public function postConstructOperations():void
		{
			_isPostConstruct = true;
			if( _settings != null ){
				passSettings();
			}
		}
		
		
		public function set settings( value:ISettings ):void
		{
			_settings = value;
			if( _isPostConstruct ){
				passSettings();
			}
		}
		
		
		/**
		 * Przekazanie danych z obiektu zawierającego ustawienia
		 * do odpowiednich modeli danych.
		 */
		private function passSettings():void
		{
			scriptsToPrepareNames = _settings.scriptsToPrepareNames;
			scriptsToExecuteNames = _settings.scriptsToExecuteNames;
			reportsTargets = _settings.reportsTargets;
			reportsFormatters = _settings.reportsFormatters;
			snapshotMode = _settings.snapshotMode;
			executionWrapper = _settings.executionWrapper;
			stepsInterval = _settings.stepsInterval;
		}
		
		
//		API - dostępne po konfiguracji AutomationCaptain'a
		
		/**
		 * Określenie listy nazw skryptów, które mają być wzięte
		 * pod uwagę przy dalszych operacjach na skryptach.
		 */
		public function set scriptsToPrepareNames( scriptsNames:Array ):void
		{
			scriptsModel.scriptsToPrepareNames = scriptsNames;
		}
		
		
		/**
		 * Określenie listy nazw skryptów, które mają zostać wykonane.
		 */
		public function set scriptsToExecuteNames( scriptsNames:Array ):void
		{
			scriptsModel.scriptsToExecuteNames = scriptsNames;
		}
		
		/**
		 * Przekazanie listy obiektów wysyłających raporty do punktów docelowych.
		 */
		public function set reportsTargets( reportsClasses:Array ):void
		{
			reportModel.reportsTargets = reportsClasses;
		}
		
		/**
		 * Przekazanie listy obiektów formatujących dane do docelowych raportu.
		 */
		public function set reportsFormatters( value:Array ):void
		{
			reportModel.reportsFormatters = value;
		}
		
		/**
		 * Przekazanie trybu wykonywania snapshota.
		 */
		public function set snapshotMode( value:String ):void
		{
			snapshotModel.mode = value;
		}
		
		/**
		 * Przekazanie nazwy wrappera, który będzie osadzał Structure
		 * (wewnętrzny aplikacji bądź zewnętrzna przeglądarka).
		 */
		public function set executionWrapper( value:String ):void
		{
			environmentModel.executionWrapper = value;
		}
				
		/**
		 * Przekazanie interwały czasowego między wykonywanymi krokami.
		 * @param value Wielkość interwału w milisekundach
		 */
		public function set stepsInterval( value:int ):void
		{
			executionModel.stepsInterval = value;
		}
	}
}