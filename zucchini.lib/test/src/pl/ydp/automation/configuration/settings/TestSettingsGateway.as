package pl.ydp.automation.configuration.settings
{
	import flash.events.Event;
	
	import mockolate.mock;
	import mockolate.nice;
	import mockolate.prepare;
	import mockolate.strict;
	import mockolate.verify;
	
	import org.flexunit.async.Async;
	
	import pl.ydp.automation.configuration.EnvironmentModel;
	import pl.ydp.automation.execution.ExecutionModel;
	import pl.ydp.automation.execution.report.ReportModel;
	import pl.ydp.automation.execution.storage.snapshot.SnapshotsModel;
	import pl.ydp.automation.scripts.ScriptsModel;
	import pl.ydp.automation.configuration.settings.ISettings;
	import pl.ydp.automation.configuration.settings.SettingsGateway;

	public class TestSettingsGateway
	{		
		
		private var settingsGateway:SettingsGateway;
		
		private var scriptsModel:ScriptsModel;
		private var reportModel:ReportModel;
		private var snapshotsModel:SnapshotsModel;
		private var environmentModel:EnvironmentModel;
		private var executionModel:ExecutionModel;
		private var settings:ISettings;
		
		[Before]
		public function setUp():void
		{
			scriptsModel = strict( ScriptsModel );
			reportModel = strict( ReportModel );
			snapshotsModel = strict( SnapshotsModel );
			environmentModel = strict( EnvironmentModel );
			executionModel = strict( ExecutionModel );
			
			settings = nice( ISettings );
			
			settingsGateway = new SettingsGateway();
			settingsGateway.scriptsModel = scriptsModel;
			settingsGateway.reportModel = reportModel;
			settingsGateway.snapshotModel = snapshotsModel;
			settingsGateway.environmentModel = environmentModel;
			settingsGateway.executionModel = executionModel;
		}
		
		[After]
		public function tearDown():void
		{
		}
		
		[Test]
		public function should_pass_scripts_to_model():void
		{
//			given
			mock( scriptsModel ).setter( 'scriptsToPrepareNames' ).once();
			mock( scriptsModel ).setter( 'scriptsToExecuteNames' ).once();
			mock( reportModel ).setter( 'reportsTargets' ).once();
			mock( reportModel ).setter( 'reportsFormatters' ).once();
			mock( reportModel ).setter( 'instantExport' ).once();
			mock( snapshotsModel ).setter( 'mode' ).once();
			mock( environmentModel ).setter( 'executionWrapper' ).once();
			mock( executionModel ).setter( 'executionMode' ).once();
			mock( executionModel ).setter( 'stepsInterval' ).once();
			mock( executionModel ).setter( 'stopOnFailure' ).once();
			
//			when
			settingsGateway.postConstructOperations();
			settingsGateway.settings = settings;
			
//			then
			verify( scriptsModel );
		}

		[Test]
		public function should_no_pass_scripts_to_model_A():void
		{
			//			given
			mock( scriptsModel ).setter( 'scriptsToPrepareNames' ).never();
			mock( scriptsModel ).setter( 'scriptsToExecuteNames' ).never();
			mock( reportModel ).setter( 'reportsTargets' ).never();
			mock( reportModel ).setter( 'reportsFormatters' ).never();
			mock( reportModel ).setter( 'instantExport' ).never();
			mock( snapshotsModel ).setter( 'mode' ).never();
			mock( environmentModel ).setter( 'executionWrapper' ).never();
			mock( executionModel ).setter( 'executionMode' ).never();
			mock( executionModel ).setter( 'stepsInterval' ).never();
			mock( executionModel ).setter( 'stopOnFailure' ).never();
			
			//			when
			settingsGateway.postConstructOperations();
			
			//			then
			verify( scriptsModel );
		}

		[Test]
		public function should_no_pass_scripts_to_model_B():void
		{
			//			given
			mock( scriptsModel ).setter( 'scriptsToPrepareNames' ).never();
			mock( scriptsModel ).setter( 'scriptsToExecuteNames' ).never();
			mock( reportModel ).setter( 'reportsTargets' ).never();
			mock( reportModel ).setter( 'reportsFormatters' ).never();
			mock( reportModel ).setter( 'instantExport' ).never();
			mock( snapshotsModel ).setter( 'mode' ).never();
			mock( environmentModel ).setter( 'executionWrapper' ).never();
			mock( executionModel ).setter( 'executionMode' ).never();
			mock( executionModel ).setter( 'stepsInterval' ).never();
			mock( executionModel ).setter( 'stopOnFailure' ).never();
			
			//			when
			settingsGateway.settings = settings;
			
			//			then
			verify( scriptsModel );
		}
		
		
		
		[BeforeClass(async, timeout=100)]
		public static function setUpBeforeClass():void
		{
			Async.proceedOnEvent(TestSettingsGateway,
				prepare( 
					ScriptsModel, 
					ReportModel, 
					ISettings,
					SnapshotsModel,
					EnvironmentModel,
					ExecutionModel
				),
				Event.COMPLETE);
		}
		
		[AfterClass]
		public static function tearDownAfterClass():void
		{
		}
		
		
	}
}