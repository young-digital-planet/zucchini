package pl.ydp.automation.fs
{
	import asx.array.length;
	
	import flash.events.Event;
	import flash.filesystem.File;
	
	import mockolate.mock;
	import mockolate.prepare;
	import mockolate.strict;
	
	import org.flexunit.assertThat;
	import org.flexunit.async.Async;
	import org.hamcrest.object.*;
	
	import pl.ydp.automation.configuration.impl.scripts.fs.FilesystemScripts;
	import pl.ydp.automation.scripts.IScriptSource;
	


	public class TestFilesystemScripts
	{	
		private var fsScripts:FilesystemScripts;
		private var scriptFolder:File;
		private var featureFile:File
		private var featuresFolder:File;
		
		[Before(async)]
		public function setUp():void
		{
			featuresFolder = strict(File);
			scriptFolder = strict(File);
			
			featureFile = strict( File );
			mock(featureFile).getter('isDirectory').returns( false );
			mock(featureFile).getter('extension').returns( FilesystemScripts.FEATURE_EXTENSION );
			mock(featureFile).getter('name').returns( 'scriptOne.feature' );
			mock(featureFile).getter('type').returns( '.feature' );
		}		
		
		[After]
		public function tearDown():void
		{
		}
		
		[Test(async)]
		public function should_find_script_and_call_event():void
		{
			prepareOneScript();
			
			assertThat( fsScripts.scriptsCount, equalTo(0) );
			
			Async.proceedOnEvent( this, fsScripts,Event.COMPLETE, 500 );
			fsScripts.initialize();
			
			var script:IScriptSource = fsScripts.getScriptSource('scriptOne');
			assertThat( script.name, equalTo( 'scriptOne' ) );
			assertThat( fsScripts.scriptsCount, equalTo(1) );
		}
		
		
		[Test(async)]
		public function should_not_find_script_and_call_event():void {			
			prepareOneScript();
			
			assertThat( fsScripts.scriptsCount, equalTo(0) );
			
			Async.proceedOnEvent( this, fsScripts,Event.COMPLETE, 500 );
			fsScripts.initialize();
			
			var script:IScriptSource = fsScripts.getScriptSource('scriptTwo');
			assertThat( script, nullValue() );
			assertThat( fsScripts.scriptsCount, equalTo(1) );
		}
		
		private function prepareOneScript():void
		{
			var files:Array = [featureFile];
			
			mock(featuresFolder).method("getDirectoryListing").returns( files );
			mock(scriptFolder).method("resolvePath").args(equalTo(FilesystemScripts.FEATURES_FOLDER)).returns( featuresFolder );
			
			fsScripts = new FilesystemScripts( scriptFolder );
		}
		
		
		[Test(async)]
		public function should_find_script_in_directory():void
		{
			var featureInDir:File = strict( File );
			mock(featureInDir).getter('isDirectory').returns( false );
			mock(featureInDir).getter('extension').returns( FilesystemScripts.FEATURE_EXTENSION );
			mock(featureInDir).getter('name').returns( 'scriptInDir.feature' );
			mock(featureInDir).getter('type').returns( '.feature' );
				
			var dirWithFeature:File = strict( File );
			mock(dirWithFeature).getter('isDirectory').returns( true );
			mock(dirWithFeature).getter('extension').returns( null );
			mock(dirWithFeature).getter('name').returns( 'dirWithFeature' );
			mock(dirWithFeature).getter('type').returns( null );
			mock(dirWithFeature).method("getDirectoryListing").returns( [featureInDir] );
			
			
			var files:Array = [featureFile, dirWithFeature];
			
			mock(featuresFolder).method("getDirectoryListing").returns( files );
			mock(scriptFolder).method("resolvePath").args(equalTo(FilesystemScripts.FEATURES_FOLDER)).returns( featuresFolder );
			
			fsScripts = new FilesystemScripts( scriptFolder );
			
			
			assertThat( fsScripts.scriptsCount, equalTo(0) );
			
			Async.proceedOnEvent( this, fsScripts,Event.COMPLETE, 500 );
			fsScripts.initialize();
			
			var scriptOne:IScriptSource = fsScripts.getScriptSource('scriptOne');
			assertThat( scriptOne.name, equalTo( 'scriptOne' ) );
			var scriptInDir:IScriptSource = fsScripts.getScriptSource('scriptInDir');
			assertThat( scriptInDir.name, equalTo( 'scriptInDir' ) );
			assertThat( fsScripts.scriptsCount, equalTo(2) );
		}
		
		[BeforeClass(async, timeout=100)]
		public static function setUpBeforeClass():void
		{
			Async.proceedOnEvent(TestFilesystemScripts,
				prepare( File ),
				Event.COMPLETE);
		}
		
		[AfterClass]
		public static function tearDownAfterClass():void
		{
		}
	}
}