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
	import pl.ydp.automation.scripts.steps.INamespaceVariables;
	import pl.ydp.automation.scripts.steps.StepsNamespace;
	

	public class TestStepsNamespace
	{		
		
		private var stepsNamespace:StepsNamespace;
		private var PATTERN:RegExp = /\w/;
		
		[Before]
		public function setUp():void
		{
			var namespaceVariables:INamespaceVariables = strict( INamespaceVariables );
			
			mock( namespaceVariables ).getter( 'variablePattern' ).returns( /{(\w+)}/g );
			mock( namespaceVariables ).getter( 'patterns' ).returns( {variable: PATTERN} );
			
			stepsNamespace = new StepsNamespace();
			stepsNamespace.namespaceVariables = namespaceVariables;
		}
		
		[After]
		public function tearDown():void
		{
		}
		
		[Test]
		public function should_get_regexp_for_variable():void
		{
//			when
			var pattern:RegExp = stepsNamespace.getRegExpForVariable( '{variable}' );
			
//			then
			assertThat( pattern, notNullValue() );
			assertThat( pattern.source, equalTo( PATTERN.source ) );
		}
		
		
		[BeforeClass(async, timeout=100)]
		public static function setUpBeforeClass():void
		{
			Async.proceedOnEvent(TestStepsNamespace,
				prepare( INamespaceVariables ),
				Event.COMPLETE);
		}
		
		[AfterClass]
		public static function tearDownAfterClass():void
		{
		}
		
		
	}
}