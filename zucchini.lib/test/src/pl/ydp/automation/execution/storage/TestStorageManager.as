package pl.ydp.automation.execution.storage
{
	import flash.events.Event;
	import flash.filesystem.File;
	
	import mockolate.mock;
	import mockolate.prepare;
	import mockolate.strict;
	
	import org.flexunit.assertThat;
	import org.flexunit.async.Async;
	import org.hamcrest.object.equalTo;
	import org.hamcrest.object.notNullValue;
	
	import pl.ydp.automation.configuration.EnvironmentModel;
	import pl.ydp.automation.execution.storage.StorageManager;
	import pl.ydp.automation.execution.storage.StorageModel;

	public class TestStorageManager
	{		
		private var storageManager:StorageManager;
		
		private var storageModel:StorageModel;
		private var environmentModel:EnvironmentModel;
		
		private var delim:String = '/';
		
		[Before]
		public function setUp():void
		{
			storageModel = strict( StorageModel );
			environmentModel = strict( EnvironmentModel );
			
			storageManager = new StorageManager();
			storageManager.storageModel = storageModel;
			storageManager.environmentModel = environmentModel;
		}
		
		[After]
		public function tearDown():void
		{
		}
		
		[Test]
		public function should_get_pattern_file():void
		{
//			given
			var snapshotFile:File = new File('/');
			
			var wrapperDirName:String = 'internal';
			
			mock( storageModel ).method( 'getSnapshotsFile' ).returns( snapshotFile );
			mock( environmentModel ).getter( 'wrapperDirName' ).returns( wrapperDirName );
			mock( environmentModel ).getter( 'filesystemDelimiter' ).returns( delim );
			
			var scriptName:String = 'scriptName';
			var lessonName:String = 'lessonName';
			var pageIndex:int = 1;
			
			var expectedUrl:String = 'file:///' + wrapperDirName + delim + scriptName + delim + lessonName + '_' + pageIndex + '.png';
			
//			when
			var patternFile:File = storageManager.getPatternFile( scriptName, lessonName, pageIndex );
			
//			then
			assertThat( patternFile, notNullValue() );
			assertThat( patternFile.url, equalTo( expectedUrl ) );
			
		}
		
		
		[Test]
		public function should_get_utt_file():void
		{
			//			given
			var dir:File = File.applicationDirectory.resolvePath( 'assets').resolvePath( 'lesson' );;
			var expectedUrl:String = 'app:/assets/lesson/script.utt';
			
			//			when
			var uttFile:File = storageManager.getUTTFileFromDir( dir );
			
			//			then
			assertThat( uttFile, notNullValue() );
			assertThat( uttFile.url, equalTo( expectedUrl ) );
		}
		
		[BeforeClass(async, timeout=100)]
		public static function setUpBeforeClass():void
		{
			Async.proceedOnEvent(TestStorageManager,
				prepare( 
					StorageModel, 
					EnvironmentModel, 
					File,
					StorageManager
				),
				Event.COMPLETE);
		}
		
		[AfterClass]
		public static function tearDownAfterClass():void
		{
		}
		
		
	}
}