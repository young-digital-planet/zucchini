package pl.ydp.automation
{
	import flash.events.Event;
	
	import mockolate.mock;
	import mockolate.prepare;
	import mockolate.strict;
	
	import org.flexunit.async.Async;
	import org.osflash.signals.Signal;
	import org.osflash.signals.utils.handleSignal;
	import org.osflash.signals.utils.proceedOnSignal;
	
	import pl.ydp.automation.scripts.ScriptsManager;
	import pl.ydp.automation.scripts.StepsManager;
	import pl.ydp.automation.scripts.parser.vo.IFeature;
	import pl.ydp.automation.ScriptsEngine;

	public class TestScriptsEngine
	{		
		private var scriptsEngine:ScriptsEngine;
		
		[Before]
		public function setUp():void
		{
			var scriptsManager:ScriptsManager = strict( ScriptsManager );
			
			mock( scriptsManager ).getter( 'scriptsInitialized' ).callsSuper();
			mock( scriptsManager ).getter( 'allScriptsLoaded' ).callsSuper();
			mock( scriptsManager ).getter( 'allScriptsParsed' ).callsSuper();
			mock( scriptsManager ).getter( 'scriptParsed' ).callsSuper();
			
			mock( scriptsManager ).method( 'initializeScripts' ).calls( 
				scriptsManager.scriptsInitialized.dispatch
			);
			mock( scriptsManager ).method( 'loadScripts' ).calls( 
				scriptsManager.allScriptsLoaded.dispatch
			);
			mock( scriptsManager ).method( 'parseScripts' ).calls( 
				scriptsManager.allScriptsParsed.dispatch
			);
			
		
			
			scriptsEngine = new ScriptsEngine();
			scriptsEngine.scriptsManager = scriptsManager;
			
		}
		
		[After]
		public function tearDown():void
		{
		}
	
		[Test(async)]
		public function should_initialize_scripts():void
		{
			proceedOnSignal( this, scriptsEngine.allScriptsAutomated, 500 );
			scriptsEngine.prepareScripts();
		}
		

		
		
		
		[BeforeClass(async, timeout=100)]
		public static function setUpBeforeClass():void
		{
			Async.proceedOnEvent(TestScriptsEngine,
				prepare( ScriptsManager ),
				Event.COMPLETE);
		}
		
		[AfterClass]
		public static function tearDownAfterClass():void
		{
		}
		
		
	}
}