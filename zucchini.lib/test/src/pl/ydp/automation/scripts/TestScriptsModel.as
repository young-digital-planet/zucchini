package pl.ydp.automation.scripts
{
	import flash.events.Event;
	
	import mockolate.mock;
	import mockolate.prepare;
	import mockolate.strict;
	import mockolate.stub;
	
	import org.flexunit.assertThat;
	import org.flexunit.async.Async;
	import org.hamcrest.object.equalTo;
	import org.hamcrest.object.notNullValue;
	
	import pl.ydp.automation.execution.AutomationScript;
	import pl.ydp.automation.scripts.ScriptsModel;

	public class TestScriptsModel
	{		
		private var scriptsModel:ScriptsModel;
		
		private var SCRIPT_NAME:String = 'script1';
		private var sourceScript:AutomationScript;
		private var resultScript:AutomationScript;
		
		
		[Before]
		public function setUp():void
		{
			scriptsModel = new ScriptsModel();
			sourceScript = strict( AutomationScript );
			mock( sourceScript ).getter( 'name' ).returns( SCRIPT_NAME );
			scriptsModel.addAutomationScript( sourceScript );
		}
		
		[After]
		public function tearDown():void
		{
			
		}
		
		[Test]
		public function should_get_automation_script_from_model():void
		{
			resultScript = scriptsModel.getAutomationScript( SCRIPT_NAME );
			assertThat( resultScript, notNullValue() );
			assertThat( resultScript.name, equalTo( SCRIPT_NAME ) );
		}
		
		
		[BeforeClass(async, timeout=100)]
		public static function setUpBeforeClass():void
		{
			Async.proceedOnEvent(TestScriptsModel,
				prepare( AutomationScript ),
				Event.COMPLETE);
		}
		
		[AfterClass]
		public static function tearDownAfterClass():void
		{
		}
		
	}
}