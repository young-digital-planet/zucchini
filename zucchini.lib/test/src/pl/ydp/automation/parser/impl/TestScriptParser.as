package pl.ydp.automation.parser.impl
{
	import flash.events.Event;
	
	import mockolate.mock;
	import mockolate.prepare;
	import mockolate.strict;
	
	import org.flexunit.assertThat;
	import org.flexunit.async.Async;
	import org.hamcrest.object.equalTo;
	import org.hamcrest.object.notNullValue;
	
	import pl.ydp.automation.scripts.IScriptSource;
	import pl.ydp.automation.scripts.parser.IScriptParser;
	import pl.ydp.automation.scripts.parser.impl.ScriptParser;
	import pl.ydp.automation.scripts.parser.vo.IFeature;

	public class TestScriptParser
	{		
		
		private var scriptParser:IScriptParser;
		private var scriptSource:IScriptSource;
		private var feature:IFeature;
		
		private const SCRIPT_NAME:String = 'scriptName';
		
		private const SCRIPT_CONTENT:String = 
			'Feature: Some terse yet descriptive text of what is desired\n' +
			'   Scenario: Some determinable business situation\n' +
			'      	 Given some And precondition\n' +
			'   Scenario: A different situation\n' +
			'       Given some precondition';
		
		[Before]
		public function setUp():void
		{
//			given
			scriptSource = strict( IScriptSource );
			mock( scriptSource ).getter( 'name' ).returns( SCRIPT_NAME );
			mock( scriptSource ).getter( 'content' ).returns( SCRIPT_CONTENT );
			scriptParser = new ScriptParser();
			
//			when
			feature = scriptParser.parse( scriptSource );
		}
		
		[After]
		public function tearDown():void
		{
			feature = null;
		}
		
		[Test]
		public function should_parse_script_source_to_feature():void
		{
			assertThat( feature, notNullValue() );
		}
		
		[Test]
		public function should_get_feature_name():void
		{
			assertThat( feature.name, equalTo( SCRIPT_NAME ) );
		}
		
		
		
		[BeforeClass(async, timeout=100)]
		public static function setUpBeforeClass():void
		{
			Async.proceedOnEvent(TestScriptParser,
				prepare( IScriptSource ),
				Event.COMPLETE);
		}
		
		[AfterClass]
		public static function tearDownAfterClass():void
		{
		}
		
		
	}
}