package pl.ydp.utils
{
	import flash.display.Loader;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.FileReference;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	
	import mx.events.FileEvent;
	
	import org.osflash.signals.Signal;

	public class FilesystemUtil
	{
		public function FilesystemUtil()
		{
		}
		
		/*
		public function loadFile( path:String ):Signal
		{
			var file:File = new File( path );
			var stream:FileStream = new FileStream();
			stream.open(file, FileMode.READ);
			var bytes:ByteArray = new ByteArray();
			stream.readBytes( bytes );
			
			return loadBytes( bytes );
		}
		*/
		public function loadFile( path:String ):Signal
		{
			var file:File = new File( path );
//			file.url = path;
			
			var bytes:ByteArray = new ByteArray();;
			if( file.exists ){
				
				var stream:FileStream = new FileStream();
				stream.open(file, FileMode.READ);
				stream.readBytes( bytes );	
			}
			
			return loadBytes( bytes );
		}
		
		
		public function loadBytes( bytes:ByteArray ):Signal
		{
			var fileLoadingCompletedSignal:Signal = new Signal();
			
			var loader:Loader = new Loader();
			var onComplete:Function = function(event:Event )
			{
				loader.contentLoaderInfo.removeEventListener( Event.COMPLETE, onComplete );
				loader.contentLoaderInfo.removeEventListener( IOErrorEvent.IO_ERROR, onError );
				fileLoadingCompletedSignal.dispatch( loader.content );
			}
			var onIOError:Function = function(event:Event )
			{
				loader.contentLoaderInfo.removeEventListener( Event.COMPLETE, onComplete );
				loader.contentLoaderInfo.removeEventListener( IOErrorEvent.IO_ERROR, onError );
				fileLoadingCompletedSignal.dispatch( );
			}
			var onError:Function = function(event:Event )
			{
				loader.contentLoaderInfo.removeEventListener( Event.COMPLETE, onComplete );
				loader.contentLoaderInfo.removeEventListener( IOErrorEvent.IO_ERROR, onError );
				fileLoadingCompletedSignal.dispatch( );
			}
			loader.contentLoaderInfo.addEventListener(	IOErrorEvent.IO_ERROR, onIOError );
			loader.contentLoaderInfo.addEventListener( Event.COMPLETE, onComplete );
			
			try{
				loader.loadBytes( bytes );
			}catch( error:ArgumentError ){
				loader.contentLoaderInfo.removeEventListener( Event.COMPLETE, onComplete );
				loader.contentLoaderInfo.removeEventListener( IOErrorEvent.IO_ERROR, onError );
				
				return null;
			}
			
			return fileLoadingCompletedSignal;
		}
		
		
		
		
		public function saveFile( path:String, bytes:ByteArray ):void
		{
			var file:File = new File( path );
			var testFileStream:FileStream = new FileStream();
			testFileStream.open(file, FileMode.WRITE);
			bytes.position = 0;
			testFileStream.writeBytes( bytes );
			testFileStream.close();     
		}
		
		
	}
}