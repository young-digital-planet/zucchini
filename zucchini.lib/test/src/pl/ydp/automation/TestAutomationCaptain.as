package pl.ydp.automation
{
	import flash.events.Event;
	
	import mockolate.mock;
	import mockolate.nice;
	import mockolate.prepare;
	import mockolate.strict;
	
	import org.flexunit.async.Async;
	import org.osflash.signals.Signal;
	import org.osflash.signals.utils.proceedOnSignal;
	
	import pl.ydp.automation.configuration.context.IAutomationAppContext;
	import pl.ydp.automation.configuration.parameters.IAutomationParameters;
	import pl.ydp.automation.scripts.ScriptsModel;
	import pl.ydp.automation.AutomationCaptain;
	import pl.ydp.automation.AutomationEngine;

	public class TestAutomationCaptain
	{		
		private var parameters:IAutomationParameters;
		private var context:IAutomationAppContext;
		private var engine:AutomationEngine;
		private var captain:AutomationCaptain;
		private var scriptsModel:ScriptsModel;
		
		[Before]
		public function setUp():void
		{
			parameters = nice( IAutomationParameters );
			context = nice( IAutomationAppContext );
			engine = strict( AutomationEngine );
			
			mock( context ).getter( 'contextCreated' ).returns( new Signal() );
			
			mock( context ).method( 'startup' ).calls(
				context.contextCreated.dispatch
			);
			
			
			mock( engine ).getter( 'allScriptsPrepared' ).callsSuper();
			
			mock( engine ).method( 'prepare' ).calls(
				engine.allScriptsPrepared.dispatch
			);
			
			
			captain = new AutomationCaptain();
			captain.context = context;
			captain.engine = engine;
		}
		
		[After]
		public function tearDown():void
		{
		}
		
		[Test(async)]
		public function should_configure_automation():void
		{
			proceedOnSignal( this, captain.configuratingCompleted, 1000 );	
			captain.configure();
		}
		
		[Test(async)]
		public function should_prepare_automation():void
		{
			proceedOnSignal( this, captain.preparingCompleted, 1000 );
			captain.prepare();
		}
		
		[Ignore('Not implemented yet')]
		[Test(async)]
		public function should_execute_automation():void
		{
//			proceedOnSignal( this, captain.executionCompleted, 1000 );
			captain.start();
		}
		
		
		[BeforeClass(async, timeout=100)]
		public static function setUpBeforeClass():void
		{
			Async.proceedOnEvent(TestAutomationCaptain,
				prepare( IAutomationAppContext, AutomationEngine, IAutomationParameters ),
				Event.COMPLETE);
		}
		
		[AfterClass]
		public static function tearDownAfterClass():void
		{
		}
		
		
	}
}