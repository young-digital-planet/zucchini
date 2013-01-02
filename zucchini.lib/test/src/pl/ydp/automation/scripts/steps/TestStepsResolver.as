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
	

	public class TestStepsResolver
	{		
		
		private var namespaceVariables:INamespaceVariables;
		private var stepsResolver:StepsResolver;
		
		private const SOURCE_PATTERN:RegExp = /press {identifier} button/;
		private const EXPECTED_PATTERN:RegExp = /press (\w+) button/;
		private const PATTERN:RegExp = /\w/;
		
		[Before]
		public function setUp():void
		{
		
			namespaceVariables = strict( INamespaceVariables );
			mock( namespaceVariables ).getter( 'variablePattern' ).returns( /{(\w+)}/g );
			
			stepsResolver = new StepsResolver();
			stepsResolver.namespaceVariables = namespaceVariables;
			
		}
		
		[After]
		public function tearDown():void
		{
		}
		
		[Test]
		public function should_get_regexp_for_variable():void
		{
			//			when
			var pattern:RegExp = stepsResolver.getRegExpForVariable( '{variable}' );
			
			//			then
			assertThat( pattern, notNullValue() );
			assertThat( pattern.source, equalTo( PATTERN.source ) );
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
				prepare( INamespaceVariables ),
				Event.COMPLETE);
		}
		
		[AfterClass]
		public static function tearDownAfterClass():void
		{
		}
		
		
	}
}