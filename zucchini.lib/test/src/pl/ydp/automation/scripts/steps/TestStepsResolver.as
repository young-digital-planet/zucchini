package pl.ydp.automation.scripts.steps
{
	import flash.events.Event;
	
	import mockolate.mock;
	import mockolate.prepare;
	import mockolate.strict;
	
	import org.flexunit.assertThat;
	import org.flexunit.async.Async;
	import org.hamcrest.object.equalTo;
	import org.hamcrest.object.notNullValue;
	import pl.ydp.automation.scripts.steps.StepsNamespace;
	import pl.ydp.automation.scripts.steps.StepsResolver;
	

	public class TestStepsResolver
	{		
		
		private var stepsNamespace:StepsNamespace;
		private var stepsResolver:StepsResolver;
		
		private const SOURCE_PATTERN:RegExp = /press {identifier} button/;
		private const EXPECTED_PATTERN:RegExp = /press (\w+) button/;
		
		[Before]
		public function setUp():void
		{
		
			stepsNamespace = strict( StepsNamespace );
			mock( stepsNamespace ).method( 'getRegExpForVariable' ).args( '{identifier}' ).returns( /\w+/ );
			mock( stepsNamespace ).getter( 'variablePattern' ).returns( /{(\w+)}/g );
			mock( stepsNamespace ).getter( 'regexpPrefix' ).returns( '(' );
			mock( stepsNamespace ).getter( 'regexpSufix' ).returns( ')' );
			
			stepsResolver = new StepsResolver();
			stepsResolver.stepsNamespace = stepsNamespace;
			
		}
		
		[After]
		public function tearDown():void
		{
		}
		
		[Test]
		public function should_get_resolved_pattern():void
		{
			var newPattern:RegExp = stepsResolver.resolvePattern( SOURCE_PATTERN );
			
			assertThat( newPattern, notNullValue() );
			assertThat( newPattern.source, equalTo( EXPECTED_PATTERN.source ) );
		}
		
		[BeforeClass(async, timeout=100)]
		public static function setUpBeforeClass():void
		{
			Async.proceedOnEvent(TestStepsResolver,
				prepare( StepsNamespace ),
				Event.COMPLETE);
		}
		
		[AfterClass]
		public static function tearDownAfterClass():void
		{
		}
		
		
	}
}