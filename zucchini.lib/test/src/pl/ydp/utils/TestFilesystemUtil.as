package pl.ydp.utils
{
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.filesystem.File;
	
	import flashx.textLayout.debug.assert;
	
	import org.flexunit.assertThat;
	import org.flexunit.asserts.assertTrue;
	import org.hamcrest.core.isA;
	import org.hamcrest.object.equalTo;
	import org.hamcrest.object.notNullValue;
	import org.hamcrest.object.nullValue;
	import org.osflash.signals.ISignal;
	import org.osflash.signals.utils.SignalAsyncEvent;
	import org.osflash.signals.utils.handleSignal;
	import pl.ydp.utils.FilesystemUtil;

	public class TestFilesystemUtil
	{		
		
		private var filesystemUtil:FilesystemUtil;
		
		[Before]
		public function setUp():void
		{
			filesystemUtil = new FilesystemUtil();
		}
		
		[After]
		public function tearDown():void
		{
		}
		
		[Test(async)]
		public function should_load_file():void
		{
			var filePath:String = 'app:/assets/kwiatek.png';
			var clazz:Class = Bitmap;
			
			var signal:ISignal = filesystemUtil.loadFile( filePath );
			handleSignal( this, signal, onFileLoaded, 500, clazz );
		}
		
		public function onFileLoaded( event:SignalAsyncEvent, clazz:Class ):void
		{
			var object = event.args.length > 0 ? event.args[0] : null;
			assertThat( object, isA( clazz ) );
		}
		
		[Test(async)]
		public function should_not_load_file():void
		{
			var filePath:String = 'app:/assets/nonExistingFile.ext';
			
			var signal:ISignal = filesystemUtil.loadFile( filePath );
			assertThat( signal, nullValue() );
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