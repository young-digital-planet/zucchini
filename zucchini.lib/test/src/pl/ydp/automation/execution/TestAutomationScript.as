package pl.ydp.automation.execution
{
	import flash.events.Event;
	
	import mockolate.mock;
	import mockolate.prepare;
	import mockolate.strict;
	
	import org.flexunit.assertThat;
	import org.flexunit.async.Async;
	import org.hamcrest.core.isA;
	import org.hamcrest.object.equalTo;
	
	import pl.ydp.automation.scripts.parser.vo.IFeature;
	import pl.ydp.automation.execution.AutomationScenario;
	import pl.ydp.automation.execution.AutomationScript;

	public class TestAutomationScript
	{		
		private var automationScript:AutomationScript;
		
		private const FEATURE_NAME:String = 'featureName';
		
		[Before]
		public function setUp():void
		{
//			given
			var feature:IFeature = strict( IFeature );
			mock( feature ).getter( 'name' ).returns( FEATURE_NAME );
			automationScript = new AutomationScript();
			
//			when
			automationScript.feature = feature;
			
			var scenario:AutomationScenario = strict( AutomationScenario );
			
			automationScript.addAutomationScenario( scenario );
		}
		
		[After]
		public function tearDown():void
		{
		}
		
		
		
		[Test]
		public function should_get_feature():void
		{
			assertThat( automationScript.feature, isA( IFeature ) );
		}
		
		[Test]
		public function should_get_name():void
		{
			assertThat( automationScript.name, equalTo( FEATURE_NAME ) );
		}
		
		[Test]
		public function should_get_scenarios():void
		{
			assertThat( automationScript.automationScenarios.length, equalTo( 1 ) ); 
			assertThat( automationScript.automationScenarios[0], isA( AutomationScenario ) );
		}
		
		
		
		[BeforeClass(async, timeout=100)]
		public static function setUpBeforeClass():void
		{
			Async.proceedOnEvent(TestAutomationScript,
				prepare( IFeature, AutomationScenario ),
				Event.COMPLETE);
		}
		
		[AfterClass]
		public static function tearDownAfterClass():void
		{
		}
		
		
	}
}