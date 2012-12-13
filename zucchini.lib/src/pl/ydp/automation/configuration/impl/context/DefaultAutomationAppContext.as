package pl.ydp.automation.configuration.impl.context
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	
	import org.osflash.signals.Signal;
	import org.robotlegs.mvcs.Context;
	
	import pl.ydp.automation.AutomationEngine;
	import pl.ydp.automation.ExecutionEngine;
	import pl.ydp.automation.ScriptsEngine;
	import pl.ydp.automation.configuration.EnvironmentModel;
	import pl.ydp.automation.configuration.StartupOperations;
	import pl.ydp.automation.configuration.context.IAutomationAppContext;
	import pl.ydp.automation.configuration.parameters.IAutomationParameters;
	import pl.ydp.automation.configuration.settings.SettingsGateway;
	import pl.ydp.automation.execution.ExecutionManager;
	import pl.ydp.automation.execution.ExecutionModel;
	import pl.ydp.automation.execution.report.ReportDataFactory;
	import pl.ydp.automation.execution.report.ReportExporter;
	import pl.ydp.automation.execution.report.ReportManager;
	import pl.ydp.automation.execution.report.ReportModel;
	import pl.ydp.automation.execution.storage.StorageManager;
	import pl.ydp.automation.execution.storage.StorageModel;
	import pl.ydp.automation.execution.storage.snapshot.SnapshotsManager;
	import pl.ydp.automation.execution.storage.snapshot.SnapshotsModel;
	import pl.ydp.automation.execution.structure.IStructure;
	import pl.ydp.automation.scripts.IScripts;
	import pl.ydp.automation.scripts.ScriptsManager;
	import pl.ydp.automation.scripts.ScriptsModel;
	import pl.ydp.automation.scripts.StepsManager;
	import pl.ydp.automation.scripts.parser.IScriptParser;
	import pl.ydp.automation.scripts.parser.ParserConfig;
	import pl.ydp.automation.scripts.steps.INamespaceVariables;
	import pl.ydp.automation.scripts.steps.IStepsClasses;
	import pl.ydp.automation.scripts.steps.StepFactory;
	import pl.ydp.automation.scripts.steps.StepsNamespace;
	import pl.ydp.automation.scripts.steps.StepsRegistry;
	import pl.ydp.automation.scripts.steps.StepsResolver;
	import pl.ydp.utils.FilesystemUtil;
	
	public class DefaultAutomationAppContext extends Context implements IAutomationAppContext
	{
		private var _parameters:IAutomationParameters;
		private var _settingsGateway:SettingsGateway;
		
		private var _contextCreated:Signal = new Signal();
		
		public function DefaultAutomationAppContext(contextView:DisplayObjectContainer=null)
		{
			if( contextView == null)
				contextView = new Sprite();
			super(contextView, false);
		}
		
		override public function startup():void
		{
			setMappingFromParameters();

			setConstMapping();
			
			finishConfiguration();
		}
		
		
		private function setMappingFromParameters():void
		{
			ParserConfig.configClass = _parameters.parserConfigClass;
			
			injector.mapValue( INamespaceVariables, _parameters.namespaceVariables );
			injector.mapValue( IStepsClasses, _parameters.steps );
			injector.mapValue( IScripts, _parameters.scripts );
			injector.mapValue( IStructure, _parameters.structure );
			injector.mapValue( IScriptParser, _parameters.scriptParser );
			
		}
		
		private function setConstMapping():void
		{
			injector.mapSingleton( AutomationEngine );
			injector.mapSingleton( StepsRegistry );
			injector.mapSingleton( StepsResolver );
			injector.mapSingleton( StepFactory );
			injector.mapSingleton( StepsManager );
			injector.mapSingleton( ScriptsModel );
			injector.mapSingleton( ScriptsManager );
			injector.mapSingleton( ScriptsEngine );
			injector.mapSingleton( ExecutionEngine );
			injector.mapSingleton( ExecutionManager );
			injector.mapSingleton( StepsNamespace );
			injector.mapSingleton( StartupOperations );
			injector.mapSingleton( StorageModel );
			injector.mapSingleton( StorageManager );
			injector.mapSingleton( ReportManager );
			injector.mapSingleton( ReportModel );
			injector.mapSingleton( ReportDataFactory );
			injector.mapSingleton( ReportExporter );
			injector.mapSingleton( SnapshotsModel );
			injector.mapSingleton( SnapshotsManager );
			injector.mapSingleton( EnvironmentModel );
			injector.mapSingleton( FilesystemUtil );
			injector.mapSingleton( ExecutionModel );
			
			
			injector.mapValue( SettingsGateway, _settingsGateway );
			injector.injectInto( _settingsGateway );
		}
		
		private function finishConfiguration():void
		{
			var startupOperations:StartupOperations = injector.getInstance( StartupOperations );
			startupOperations.operationsFinished.addOnce( onFinished );
			startupOperations.execute();
		}
		
		private function onFinished():void
		{
			_contextCreated.dispatch();
		}
		
		
		public function set parameters( automationParameters:IAutomationParameters ):void
		{
			_parameters = automationParameters;
		}
		
		public function get engine():AutomationEngine
		{
			return injector.getInstance( AutomationEngine );
		}
		
		public function set settingsGateway( gateway:SettingsGateway ):void
		{
			_settingsGateway = gateway;
		}
		
		public function get structure():IStructure
		{
			return injector.getInstance( IStructure );
		}
		
		public function get contextCreated():Signal
		{
			return _contextCreated;
		}
	}
}