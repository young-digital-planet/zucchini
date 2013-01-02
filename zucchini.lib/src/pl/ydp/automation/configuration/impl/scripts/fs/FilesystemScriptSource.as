package pl.ydp.automation.configuration.impl.scripts.fs
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.filesystem.File;
	
	import pl.ydp.automation.execution.AutomationScript;
	import pl.ydp.automation.scripts.IScriptSource;
	
	/**
	 * Implementacja pojedynczego skryptu dla systemu plików.
	 */
	public class FilesystemScriptSource extends EventDispatcher implements IScriptSource
	{
		private var _name:String;
		private var _scriptFile:File;
		private var _scriptContent:String;
		private var _automationScript:AutomationScript;
		private var _loading:Boolean;
		
		public function FilesystemScriptSource( scriptFile:File ) {
			this._scriptFile = scriptFile;
			var scriptName:String = scriptFile.name;
			this._name = scriptName.substring(0, scriptName.search(scriptFile.type));
		}
		
		/**
		 * Załadowanie zawartości skryptu z pliku.
		 */
		public function load():void {
			if ( _automationScript!=null ) {
				dispatchEvent( new Event(Event.COMPLETE) );
			} else {
				if ( !_loading ) {
					_loading = true;
					_scriptFile.addEventListener(Event.COMPLETE, scriptLoaded );
					_scriptFile.addEventListener(IOErrorEvent.IO_ERROR, scriptFailed );
					_scriptFile.load();
				}
			}
		}
		
		public function get script():AutomationScript {
			return _automationScript;
		}
		
		public function get content():String
		{
			return _scriptContent;
		}
		
		private function scriptLoaded( e:Event ):void {
			_loading = false;
			
			_scriptContent = _scriptFile.data.readUTFBytes(_scriptFile.data.length);
			
			dispatchEvent( new Event(Event.COMPLETE) );
		}
		
		private function scriptFailed( e:IOErrorEvent ):void {
			_loading = false;
			
			dispatchEvent( e );
		}
		
		public function get name():String
		{
			return _name;
		}
	}
}