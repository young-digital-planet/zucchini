package utopia.steps
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.filesystem.File;
	
	import flashx.textLayout.debug.assert;
	
	import mockolate.mock;
	import mockolate.nice;
	import mockolate.prepare;
	import mockolate.received;
	import mockolate.strict;
	import mockolate.verify;
	
	import org.flexunit.assertThat;
	import org.flexunit.async.Async;
	import org.hamcrest.core.isA;
	import org.hamcrest.object.equalTo;
	import org.osflash.signals.Signal;
	import org.osflash.signals.utils.SignalAsyncEvent;
	import org.osflash.signals.utils.handleSignal;
	import org.osflash.signals.utils.proceedOnSignal;
	
	import pl.ydp.automation.execution.storage.StorageManager;
	import pl.ydp.automation.execution.storage.snapshot.SnapshotsManager;
	import pl.ydp.automation.execution.storage.snapshot.SnapshotsModel;
	import pl.ydp.automation.execution.structure.IStructure;
	import pl.ydp.automation.scripts.steps.StepResult;
	import pl.ydp.utils.FilesystemUtil;

	[RunWith("org.flexunit.runners.Parameterized")]
	public class TestMakeSnapshotStep
	{		
		
		private var makeSnapshotStep:MakeSnapshotStep;

		private var structure:IStructure;
		private var snapshotsManager:SnapshotsManager;
		private var snapshotsModel:SnapshotsModel;
		private var storageManager:StorageManager;
		private var filesystemUtil:FilesystemUtil;
		
		private var scriptName:String = 'scriptName';
		
		private var signal:Signal;
		
		
		[Before]
		public function setUp():void
		{
			
		}
		
		[After]
		public function tearDown():void
		{
		}
		
		private function prepareMocksForExecute():void
		{
			structure = strict( IStructure );
			mock( structure ).getter( 'snapshotSource' ).returns( new Bitmap(new BitmapData(100, 100) ) );
			
			snapshotsModel = strict( SnapshotsModel );
			
			storageManager = strict( StorageManager );
			mock( storageManager ).method( 'getPatternFile' ).anyArgs().returns( new File('/') );
			
			
			makeSnapshotStep = nice( MakeSnapshotStep );
			mock( makeSnapshotStep ).method( 'execute' ).callsSuper();
			makeSnapshotStep.snapshotsModel = snapshotsModel;
			makeSnapshotStep.storageManager = storageManager;
			makeSnapshotStep.structure = structure;
		}
		
		[Test]
		public function should_call_compare_with_pattern():void
		{
//			given
			prepareMocksForExecute();
			mock( snapshotsModel ).getter( 'mode' ).returns( SnapshotsModel.COMPARE_MODE );
			
//			when
			makeSnapshotStep.execute( scriptName );
			
//			then
			assertThat( makeSnapshotStep, received().method( 'compareWithPattern' ).once() );
		}

		
		[Test]
		public function should_call_save_as_pattern():void
		{
//			given
			prepareMocksForExecute();
			mock( snapshotsModel ).getter( 'mode' ).returns( SnapshotsModel.PATTERN_MODE );
			
//			when
			makeSnapshotStep.execute( scriptName );
			
//			then
			assertThat( makeSnapshotStep, received().method( 'saveAsPattern' ).once() );
		}
		
		[Test(async)]
		public function should_fail_execution():void
		{
//			given
			prepareMocksForExecute();
			mock( snapshotsModel ).getter( 'mode' ).returns( 'nonExistingMode' );
			mock( makeSnapshotStep ).getter( 'executionCompleted' ).callsSuper();
			
//			then
			handleSignal( this, makeSnapshotStep.executionCompleted, onExecutionCompleted, 200 );
			
//			when
			makeSnapshotStep.execute( scriptName );
		}

		private function onExecutionCompleted( e:SignalAsyncEvent, data:Object ):void
		{
			var result = e.args[0];
			assertThat( result, isA( StepResult ) );
			assertThat( ( result as StepResult ).correctly, equalTo( false ) );
		}
		
	
		[Test(async)]
		public function should_compare_with_pattern_and_not_ok():void
		{
//			given
			signal = new Signal();
			
			filesystemUtil = strict( FilesystemUtil );
			mock( filesystemUtil ).method( 'loadFile' ).returns( signal );
			
			makeSnapshotStep = new MakeSnapshotStep( new RegExp() );
			makeSnapshotStep.filesystemUtil = filesystemUtil;
			
//			then
			handleSignal( this, makeSnapshotStep.executionCompleted, onCompareNotOK, 200 );
			
//			when
			makeSnapshotStep.compareWithPattern();
			signal.dispatch( null );
			
		}
		
		private function onCompareNotOK( e:SignalAsyncEvent, data:Object ):void
		{
			var result = e.args[0];
			assertThat( result, isA( StepResult ) );
			assertThat( ( result as StepResult ).correctly, equalTo( false ) );
		}
		
		[Test(async)]
		public function should_save_as_pattern():void
		{
//			given
			filesystemUtil = nice( FilesystemUtil );
			
			makeSnapshotStep = new MakeSnapshotStep( new RegExp() );
			makeSnapshotStep.filesystemUtil = filesystemUtil;
			makeSnapshotStep._currentSnapshot = new BitmapData( 100, 100 );
			
			//			then
			handleSignal( this, makeSnapshotStep.executionCompleted, onSaveAsPattern, 200 );
			
			//			when
			makeSnapshotStep.saveAsPattern();
		}
		
		private function onSaveAsPattern( e:SignalAsyncEvent, data:Object ):void
		{
			var result = e.args[0];
			assertThat( result, isA( StepResult ) );
			assertThat( ( result as StepResult ).correctly, equalTo( true ) );
		}
		
		
		
		
		[BeforeClass(async, timeout=100)]
		public static function setUpBeforeClass():void
		{
			Async.proceedOnEvent(TestMakeSnapshotStep,
				prepare( 
					FilesystemUtil, 
					SnapshotsManager,
					SnapshotsModel,
					StorageManager,
					FilesystemUtil,
					IStructure,
					MakeSnapshotStep
				),
				Event.COMPLETE);
		}
		
		[AfterClass]
		public static function tearDownAfterClass():void
		{
		}
		
		
	}
}