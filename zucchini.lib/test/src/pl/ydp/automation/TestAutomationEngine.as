package pl.ydp.automation
{
	import flash.events.Event;
	
	import mockolate.mock;
	import mockolate.nice;
	import mockolate.prepare;
	import mockolate.strict;
	
	import org.flexunit.async.Async;
	import org.osflash.signals.utils.proceedOnSignal;
	import pl.ydp.automation.AutomationEngine;
	import pl.ydp.automation.ExecutionEngine;
	import pl.ydp.automation.ScriptsEngine;

	public class TestAutomationEngine
	{		
		private var automationEngine:AutomationEngine;
		private var scriptsEngine:ScriptsEngine;
		private var executionEngine:ExecutionEngine;
		
		[Before]
		public function setUp():void
		{
			scriptsEngine = strict( ScriptsEngine );
			executionEngine = nice( ExecutionEngine );
			
			mock( scriptsEngine ).getter( 'allScriptsAutomated' ).callsSuper();
			
			mock( scriptsEngine ).method( 'prepareScripts' ).calls( 
				scriptsEngine.allScriptsAutomated.dispatch
			);
			
			mock( executionEngine ).getter( 'executionCompleted' ).callsSuper();
			
			mock( executionEngine ).method( 'start' ).calls( 
				executionEngine.executionCompleted.dispatch
			);
			
			automationEngine = new AutomationEngine();
			automationEngine.scriptEngine = scriptsEngine;
			automationEngine.executionEngine = executionEngine;
			
		}
		
		[After]
		public function tearDown():void
		{
		}
		
		[Test(async)]
		public function should_prepare_scripts():void
		{
//			then
			proceedOnSignal( this, automationEngine.allScriptsPrepared, 500 );
			
//			when
			automationEngine.prepare();
		}
		
		[Test(async)]
		public function should_execute_scripts():void
		{
			//			then
			proceedOnSignal( this, automationEngine.automationCompleted, 500 );
			
			//			when
			automationEngine.start();
		}
		
		
		
		
		[BeforeClass(async, timeout=100)]
		public static function setUpBeforeClass():void
		{
			Async.proceedOnEvent(TestAutomationEngine,
				prepare( ScriptsEngine, ExecutionEngine ),
				Event.COMPLETE);
		}
		
		[AfterClass]
		public static function tearDownAfterClass():void
		{
		}
		
		
	}
}