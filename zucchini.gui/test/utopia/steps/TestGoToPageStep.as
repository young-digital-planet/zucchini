package utopia.steps
{
	import flash.display.DisplayObject;
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
	import pl.ydp.automation.execution.structure.IStructure;
	import pl.ydp.automation.execution.structure.impl.utopia.UtopiaStructureComponent;
	import pl.ydp.automation.scripts.steps.StepResult;
	import pl.ydp.p2.modules.test.ui.YTestSwitcher;

	public class TestGoToPageStep
	{		
		private var goToPageStep:GoToPageStep;
		
		
		[Before]
		public function setUp():void
		{
			goToPageStep = new GoToPageStep( new RegExp() );
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
			var element:YTestSwitcher = new YTestSwitcher();
			
			var structure:IStructure = strict( UtopiaStructureComponent );
			mock( structure ).method( 'getElement' ).anyArgs().returns( element );
			
			var func:Function = function ( mod:DisplayObject):*{
					return true;
			};
			
			var utopiaStepsUtil:UtopiaStepsUtil = new UtopiaStepsUtil();

			var executionModel:ExecutionModel = strict( ExecutionModel );
			mock( executionModel ).getter( 'executionMode' ).returns( ExecutionModel.NORMAL_EXECUTION );
			
			goToPageStep.executionModel = executionModel;
			goToPageStep.structure = structure;
			goToPageStep.utopiaStepsUtil = utopiaStepsUtil;
			
			goToPageStep._pageIndex = 1;
			
//			then
			handleSignal( this, goToPageStep.executionCompleted, onExecutionCompleted, 2000 );
			
//			when
			goToPageStep.execute( '' );
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
			Async.proceedOnEvent(TestGoToPageStep,
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