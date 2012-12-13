package pl.ydp.automation.configuration.impl.scripts.fs
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.FileListEvent;
	import flash.events.IOErrorEvent;
	import flash.filesystem.File;
	
	import flex.lang.reflect.Field;
	
	import pl.ydp.automation.scripts.IScriptSource;
	import pl.ydp.automation.scripts.IScripts;
	import pl.ydp.utils.EventUtils;
	import pl.ydp.utils.UriUtil;
	
	public class FilesystemScripts extends EventDispatcher implements IScripts
	{
		private const FEATURES_PARENT_DIRECTORY:String = 'files';
		private var _root:File;
		private var _scripts:Object = { };
		private var _scriptsCount:int = 0;
		
		public function FilesystemScripts( scriptsDir:File = null )
		{
			if( scriptsDir == null){
				scriptsDir = File.applicationDirectory.resolvePath( FEATURES_PARENT_DIRECTORY );
			}
			this._root = scriptsDir;
		}
		
		public function initialize():void {
			var featuresDir:File = this._root.resolvePath( "features" );
			featuresDir.addEventListener(FileListEvent.DIRECTORY_LISTING, gotDirectoryListing );
			featuresDir.addEventListener(IOErrorEvent.IO_ERROR, EventUtils.redispatch(this) );
			featuresDir.getDirectoryListingAsync();
		}
		
		public function getScriptSource( name:String ):IScriptSource {
			return _scripts[name];
		}
		
		protected function gotDirectoryListing( e:FileListEvent ):void {
			for each( var aFile:File in e.files ) {
				if ( !aFile.isDirectory && aFile.extension=="feature" ) {
					_scripts[UriUtil.filename(aFile.name)] = 
						new FilesystemScriptSource(aFile);
				}
			}
			_scriptsCount = getScriptsCount();
			dispatchEvent( new Event(Event.COMPLETE) );
		}

	
		
		private function getScriptsCount():int
		{
			var count:int = 0;
			for(var key in scripts){
				count++;
			}
			return count;
		}
		
		public function get scripts():Object
		{
			return _scripts;
		}
		
		public function get scriptsCount():int
		{
			return _scriptsCount;
		}
		
	}
}