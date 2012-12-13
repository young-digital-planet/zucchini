package utopia.steps
{
	import flash.events.Event;
	import flash.filesystem.File;
	
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
	import pl.ydp.automation.execution.storage.StorageManager;
	import pl.ydp.automation.execution.structure.impl.utopia.UtopiaStructureComponent;
	import pl.ydp.automation.scripts.steps.StepResult;

	public class TestLoadLessonStep
	{	
		private var loadLessonStep:LoadLessonStep;
		
		
		[Before]
		public function setUp():void
		{
			loadLessonStep = new LoadLessonStep( new RegExp() );
		}
		
		[After]
		public function tearDown():void
		{
		}
		
		
		[Test(async)]
		public function should_complete_step():void
		{
//			given
			var structure:UtopiaStructureComponent = strict( UtopiaStructureComponent );
			mock( structure ).method( 'loadLessonPage' ).anyArgs().dispatches(
				new Event( 'contentLoadingCompleted' )
			);
			
			var lessonFile:File = new File('/');
			
			var storageManager:StorageManager = strict( StorageManager );
			mock( storageManager ).method( 'getLessonFile' ).anyArgs().returns( lessonFile );
			
			var executionModel:ExecutionModel = strict( ExecutionModel );
			mock( executionModel ).getter( 'executionMode' ).returns( ExecutionModel.NORMAL_EXECUTION );
			
			loadLessonStep.executionModel = executionModel;
			loadLessonStep.storageManager = storageManager;
			loadLessonStep.structure = structure;
			loadLessonStep._pageIndex = 1;
			
//			then
			handleSignal( this, loadLessonStep.executionCompleted, onExecutionCompleted, 5000 );
			
//			when
			loadLessonStep.execute( '' );
		}
		
		private function onExecutionCompleted( event:SignalAsyncEvent, data ):void
		{
			var result:StepResult = event.args[ 0 ];
			assertThat( result, notNullValue() );
			assertThat( result.correctly, equalTo( true ) );
		}
		
		
		[BeforeClass(async, timeout=100)]
		public static function setUpBeforeClass():void
		{
			Async.proceedOnEvent(TestLoadLessonStep,
				prepare( 
					UtopiaStructureComponent,
					StorageManager,
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