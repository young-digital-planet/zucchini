package utopia.steps
{
	import flash.events.Event;
	import flash.utils.getDefinitionByName;
	
	import mockolate.mock;
	import mockolate.nice;
	import mockolate.prepare;
	import mockolate.strict;
	
	import org.flexunit.assertThat;
	import org.flexunit.async.Async;
	import org.hamcrest.core.anyOf;
	import org.hamcrest.object.equalTo;
	import org.hamcrest.object.notNullValue;
	import org.osflash.signals.utils.SignalAsyncEvent;
	import org.osflash.signals.utils.handleSignal;
	
	import pl.ydp.automation.execution.ExecutionModel;
	import pl.ydp.automation.execution.structure.impl.utopia.UtopiaStructureComponent;
	import pl.ydp.automation.scripts.steps.StepResult;
	import pl.ydp.p2.modules.textinteraction.textEntry.YTextEntry;
	import utopia.steps.FillTextInputStep;
	import utopia.steps.UtopiaStepsUtil;

	public class TestFillTextInputStep
	{		
		private var fillTextInputStep:FillTextInputStep;
		
		
		[Before]
		public function setUp():void
		{
			fillTextInputStep = new FillTextInputStep( new RegExp() );
			
		}
		
		[After]
		public function tearDown():void
		{
		}
		
		[Ignore('zbyt złożony cykl życia komponentów Utopii')]
		[Test(async)]
		public function should_complete_step():void
		{
//			given
			var element:YTextEntry = new YTextEntry();
			
			var structure:UtopiaStructureComponent = strict( UtopiaStructureComponent );
			mock( structure ).method( 'getElement' ).anyArgs().returns( element );
			
			var func:Function = function(){};
			
			var utopiaStepsUtil:UtopiaStepsUtil = new UtopiaStepsUtil();
			
			var executionModel:ExecutionModel = strict( ExecutionModel );
			mock( executionModel ).getter( 'executionMode' ).returns( ExecutionModel.NORMAL_EXECUTION );
			
			fillTextInputStep.executionModel = executionModel;
			fillTextInputStep.structure = structure;
			fillTextInputStep.utopiaStepsUtil = utopiaStepsUtil;
			
			fillTextInputStep._textInput = '#1';
			fillTextInputStep._value = 'text';
			
//			then
			handleSignal( this, fillTextInputStep.executionCompleted, onExecutionCompleted, 100 );
			
//			when
			fillTextInputStep.execute( '' );
		}
		
		
		
		private function onExecutionCompleted( event:SignalAsyncEvent ):void
		{
			var result:StepResult = event.args[ 0 ];
			assertThat( result, notNullValue() );
			assertThat( result.correctly, equalTo( true ) );
		}
		
		
		[BeforeClass(async, timeout=100)]
		public static function setUpBeforeClass():void
		{
			Async.proceedOnEvent(TestFillTextInputStep,
				prepare( 
					YTextEntry, 
					UtopiaStructureComponent, 
					UtopiaStepsUtil,
					ExecutionModel
				),
				Event.COMPLETE);
		}
		
		[AfterClass]
		public static function tearDownAfterClass():void
		{
		}
		
		
	}
}