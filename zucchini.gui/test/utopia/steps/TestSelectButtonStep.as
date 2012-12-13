package utopia.steps
{
	import flash.events.Event;
	
	import mockolate.mock;
	import mockolate.nice;
	import mockolate.prepare;
	import mockolate.strict;
	
	import org.flexunit.assertThat;
	import org.flexunit.async.Async;
	import org.hamcrest.object.equalTo;
	import org.hamcrest.object.notNullValue;
	import org.osflash.signals.utils.SignalAsyncEvent;
	import org.osflash.signals.utils.handleSignal;
	
	import pl.ydp.automation.execution.ExecutionModel;
	import pl.ydp.automation.execution.structure.impl.utopia.UtopiaStructureComponent;
	import pl.ydp.automation.scripts.steps.StepResult;
	import pl.ydp.p2.modules.simplechoice.YSimpleChoice;

	public class TestSelectButtonStep
	{		
		private var selectButtonStep:SelectButtonStep;
		
		
		
		[Before]
		public function setUp():void
		{
			selectButtonStep = new SelectButtonStep( new RegExp() );
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
			var element:YSimpleChoice = new YSimpleChoice();
			
			var structure:UtopiaStructureComponent = strict( UtopiaStructureComponent );
			mock( structure ).method( 'getElement' ).anyArgs().returns( element );
			
			var func:Function = function(){};
			
			var utopiaStepsUtil:UtopiaStepsUtil = new UtopiaStepsUtil();
			
			var executionModel:ExecutionModel = strict( ExecutionModel );
			mock( executionModel ).getter( 'executionMode' ).returns( ExecutionModel.NORMAL_EXECUTION );
			
			selectButtonStep.executionModel = executionModel;
			selectButtonStep.structure = structure;
			selectButtonStep.utopiaStepsUtil = utopiaStepsUtil;
			
			selectButtonStep._option = '#1';
			
//			then
			handleSignal( this, selectButtonStep.executionCompleted, onExecutionCompleted, 100 );
			
//			when
			selectButtonStep.execute( '' );
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
			Async.proceedOnEvent(TestSelectButtonStep,
				prepare( 
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