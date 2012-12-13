package pl.ydp.automation.fs
{
	import flash.events.Event;
	import flash.events.FileListEvent;
	import flash.filesystem.File;
	import flash.utils.ByteArray;
	
	import mockolate.ingredients.answers.Answer;
	import mockolate.mock;
	import mockolate.nice;
	import mockolate.prepare;
	import mockolate.strict;
	
	import org.flexunit.assertThat;
	import org.flexunit.async.Async;
	import org.hamcrest.core.anything;
	import org.hamcrest.object.*;
	
	import pl.ydp.automation.configuration.impl.scripts.fs.FilesystemScripts;
	import pl.ydp.automation.scripts.IScriptSource;
	import pl.ydp.utils.FuncUtil;
	


	public class TestFilesystemScripts
	{	
		private var fsScripts:FilesystemScripts;
		private var scriptFolder:File;
		
		[Before(async)]
		public function setUp():void
		{
			var featuresFolder:File = nice(File);
			scriptFolder = nice(File);
			var fle:FileListEvent = new FileListEvent(FileListEvent.DIRECTORY_LISTING);
				var featureFile:File = nice(File);
				mock(featureFile).getter("isDirectory").returns(false);
				mock(featureFile).getter("extension").returns("feature");
				mock(featureFile).getter("name").returns("scriptOne.feature");
				mock(featureFile).method("addEventListener").anyArgs().callsSuper();
				mock(featureFile).method("load").noArgs().dispatches( new Event(Event.COMPLETE), 10);
				mock(featureFile).getter("data").returns( new ByteArray() );
				var featureDir:File = strict(File);
				mock(featureDir).getter("isDirectory").returns(true);
				mock(featureDir).getter("extension").returns("feature");
				mock(featureDir).getter("name").returns("scriptTwo.feature");
			fle.files = [ featureDir, featureFile ];
			
			mock(scriptFolder).method("resolvePath").args(equalTo("features")).returns( featuresFolder );
			mock(featuresFolder).method("getDirectoryListingAsync").dispatches(fle);
			
			fsScripts = new FilesystemScripts( scriptFolder );
			Async.proceedOnEvent(this,fsScripts, Event.COMPLETE,2000);
			fsScripts.initialize();
		}
		
		[BeforeClass(async, timeout=5000)]
		static public function prepareMockolates():void
		{
			Async.proceedOnEvent(TestFilesystemScripts,
				prepare(File),
				Event.COMPLETE);
		}
		
		[After]
		public function tearDown():void
		{
		}
		
		[Test(order=1)]
		public function should_find_script_source():void {			
			var scriptSource:IScriptSource = fsScripts.getScriptSource( "scriptOne" );
			
			assertThat( scriptSource, notNullValue() );
		}
		
		[Test(order=10)]
		public function should_not_find_script_source_from_directory():void {			
			var scriptSource:IScriptSource = fsScripts.getScriptSource( "scriptTwo" );
			
			assertThat( scriptSource, nullValue() );
		}
		
		[Test(async, order=20)]
		public function should_call_event_when_loads_script():void {
			var scriptSource:IScriptSource = fsScripts.getScriptSource( "scriptOne" );
			
			assertThat( scriptSource.script, nullValue() );
			Async.handleEvent( this, scriptSource, Event.COMPLETE, scriptLoadedHandler );
			scriptSource.load();
		}
		
		private function scriptLoadedHandler( e:Event, data:* ):void {
			assertThat( (e.target as IScriptSource).content, notNullValue() );
		}
		
		[Test(async, order=30)]
		public function should_call_event_when_loads_loaded_script():void {
			var scriptFolder:File = nice(File);
			
			var scriptSource:IScriptSource = fsScripts.getScriptSource( "scriptOne" );
			
			assertThat( scriptSource.script, nullValue() );
			
			var info:* = { };
			info.ahandler = Async.asyncHandler(this, function(... a):void{}, 1500 );
			info.rhandler = FuncUtil.AddArguments(scriptLoadedLoadsHandler,info);
			scriptSource.addEventListener( Event.COMPLETE, info.rhandler );
			scriptSource.load();
		}
		
		private function scriptLoadedLoadsHandler( e:Event, info:* ):void {
			var scriptSource:IScriptSource = (e.target as IScriptSource);
			assertThat( scriptSource.content, notNullValue() );
			scriptSource.removeEventListener( Event.COMPLETE, info.rhandler );
			
			scriptSource.addEventListener( Event.COMPLETE, FuncUtil.AddArguments(scriptLoadedDoubleHandler,info.ahandler) );
			scriptSource.load();
		}
		
		private function scriptLoadedDoubleHandler( e:Event, ends:Function ):void {
			var scriptSource:IScriptSource = (e.target as IScriptSource);
			assertThat( scriptSource.content, notNullValue() );
			
			ends(e);
		}
		
		[BeforeClass]
		public static function setUpBeforeClass():void
		{
		}
		
		[AfterClass]
		public static function tearDownAfterClass():void
		{
		}
		
		
	}
}