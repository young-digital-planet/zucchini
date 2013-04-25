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
	
	/** Implementacja źródła skryptów dla systemu plików.
	 */
	public class FilesystemScripts extends EventDispatcher implements IScripts
	{
		public static const FEATURES_PARENT_DIRECTORY:String = 'files';
		public static const FEATURES_FOLDER:String = 'features';
		public static const FEATURE_EXTENSION:String = 'feature';
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
		
		/**
		 * Listowanie folderu źródłowego i mapowanie skryptów na obiekty.
		 */
		public function initialize():void {
			var featuresDir:File = this._root.resolvePath( FEATURES_FOLDER );
			findScriptsInDir( featuresDir );
			dispatchEvent( new Event(Event.COMPLETE) );
		}
		
		
		
		private function findScriptsInDir( dir:File ):void
		{
			var files:Array = dir.getDirectoryListing();
			for each( var file:File in files ) {
				if ( file.isDirectory ){
					findScriptsInDir( file );
				}else if ( isFeature( file ) ) {
					addScript( file );
				}
			}
			_scriptsCount = getScriptsCount();
		}

		private function isFeature( file:File ):Boolean
		{
			return file.extension == FEATURE_EXTENSION;
		}
		
		private function addScript( file:File ):void
		{
			_scripts[UriUtil.filename(file.name)] = 
				new FilesystemScriptSource(file);
		}
		
		public function getScriptSource( name:String ):IScriptSource {
			return _scripts[name];
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