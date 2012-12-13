package pl.ydp.automation.scripts
{
	import flash.events.Event;
	
	import mockolate.mock;
	import mockolate.prepare;
	import mockolate.strict;
	
	import org.flexunit.async.Async;
	import org.osflash.signals.utils.proceedOnSignal;
	
	import pl.ydp.automation.scripts.parser.IScriptParser;
	import pl.ydp.automation.scripts.parser.vo.IFeature;
	import pl.ydp.automation.scripts.IScriptSource;
	import pl.ydp.automation.scripts.IScripts;
	import pl.ydp.automation.scripts.ScriptsManager;
	import pl.ydp.automation.scripts.ScriptsModel;

	public class TestScriptsManager
	{		
		private var scriptsManager:ScriptsManager;
		private var scripts:IScripts;
		private var scriptSource:IScriptSource;
		private var scriptsModel:ScriptsModel;
		
		[Before]
		public function setUp():void
		{
			scripts = strict( IScripts );
			scriptSource = strict( IScriptSource );
			
			mock( scripts ).getter( 'scripts' ).returns( { name:scriptSource } );
			mock( scripts ).getter( 'scriptsCount' ).returns( 1 );
			
			mock( scriptSource ).getter( 'name' ).returns( 'name' );
			
			scriptsManager = new ScriptsManager();
			scriptsManager.scripts = scripts;
			scriptsManager.scriptsModel = new ScriptsModel();
		}
		
		[After]
		public function tearDown():void
		{
		}
		
		[Test(async,order=1)]
		public function should_initialize_scripts():void
		{
//			given
			mock( scripts ).method( 'initialize' ).dispatches( new Event(Event.COMPLETE) );
			
//			then
			Async.proceedOnEvent( this, scriptsManager.scripts, Event.COMPLETE, 500 );
			proceedOnSignal( this, scriptsManager.scriptsInitialized, 500 );
			
//			when
			scriptsManager.initializeScripts();
		}
		
		[Test(async,order=2)]
		public function should_load_scripts():void
		{
//			given
			mock( scripts ).method( 'getScriptSource' ).anyArgs().returns( scriptSource );
			mock( scriptSource ).method( 'load' ).dispatches( new Event(Event.COMPLETE) );
			
			
//			then
			proceedOnSignal( this, scriptsManager.allScriptsLoaded, 1000 );
			
//			when
			scriptsManager.loadScripts();
		}
		
		[Test(async,order=3)]
		public function should_parse_scripts():void
		{
//			given
			var scriptParser:IScriptParser = strict( IScriptParser );
			var feature:IFeature = strict( IFeature );
			
			mock( scriptParser ).method( 'parse' ).anyArgs().returns( feature );
			
			scriptsManager._scriptsToPrepare = [ scriptSource ];
			
			scriptsManager.scriptParser = scriptParser;
			
//			then
			proceedOnSignal( this, scriptsManager.scriptParsed, 1000 );
			
//			when
			scriptsManager.parseScripts();
		}
		
		
		
		[BeforeClass(async, timeout=100)]
		public static function setUpBeforeClass():void
		{
			Async.proceedOnEvent(TestScriptsManager,
				prepare( IScripts, IScriptSource, IScriptParser, IFeature ),
				Event.COMPLETE);
		}
		
		[AfterClass]
		public static function tearDownAfterClass():void
		{
		}
		
		
	}
}