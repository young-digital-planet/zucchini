package pl.ydp.automation.scripts
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	
	import org.osflash.signals.Signal;
	
	import pl.ydp.automation.scripts.parser.IScriptParser;
	import pl.ydp.automation.scripts.parser.vo.IFeature;

	/**
	 * Manager zapewniający kontrolę nad źródłem skryptów.
	 */
	public class ScriptsManager extends EventDispatcher
	{
		[Inject]
		public var scriptParser:IScriptParser;
		[Inject]
		public var scripts:IScripts;
		[Inject]
		public var scriptsModel:ScriptsModel;
		
		private var _scriptsInitialized:Signal = new Signal();
		private var _allScriptsLoaded:Signal = new Signal();
		private var _scriptParsed:Signal = new Signal();
		private var _allScriptsParsed:Signal = new Signal();
		
		private var _initialized:Boolean = false;
		
		
		internal var _scriptsToPrepare:Array;
		
		private var _loadedScriptsCount:int = 0;
		private var _parsedScriptsCount:int = 0;
		
		public function ScriptsManager()
		{
		}
		
		public function initializeScripts():void
		{
			scripts.addEventListener( Event.COMPLETE, onScriptsInitialized );
			scripts.addEventListener( IOErrorEvent.IO_ERROR, onInitializeError );
			scripts.initialize();
		}
		
		private function onInitializeError():void
		{
			
		}
		
		private function onScriptsInitialized(e:Event):void
		{
			_initialized = true;
			_scriptsInitialized.dispatch();
		}
		
		public function prepareScriptsArray():void
		{
			_scriptsToPrepare = [];
			
			if( scriptsModel.scriptsToPrepareNames != null && scriptsModel.scriptsToPrepareNames.length > 0){
				for each(var scriptName:String in scriptsModel.scriptsToPrepareNames){
					_scriptsToPrepare.push( scripts.getScriptSource( scriptName ) );
				}
			}else{
				for each(var scriptSource:IScriptSource in scripts.scripts){
					_scriptsToPrepare.push( scriptSource );
				}
			}
			
		}
		
		public function loadScripts():void
		{
			prepareScriptsArray();
			
			_loadedScriptsCount = 0;
			
			for each(var scriptSource:IScriptSource in _scriptsToPrepare ){
				loadScript( scriptSource );
			}
		}
		
		public function loadScript( scriptSource:IScriptSource ):void
		{
			scriptSource.addEventListener( Event.COMPLETE, onLoadComplete );
			scriptSource.addEventListener( IOErrorEvent.IO_ERROR, onLoadError );
			scriptSource.load();
		}
		
		private function onLoadError( e:IOErrorEvent ):void
		{
			removeListeners( e.target );
		}
		
		private function onLoadComplete(e:Event):void
		{
			removeListeners( e.target );
			
			_loadedScriptsCount++;
			
			if( _loadedScriptsCount == _scriptsToPrepare.length ){
				_allScriptsLoaded.dispatch();
				scriptsModel.scriptsToPrepareNames = null;
			}
		}
		
		
		private function removeListeners( target:* ):void
		{
			target.removeEventListener( Event.COMPLETE, onLoadComplete );
			target.removeEventListener( IOErrorEvent.IO_ERROR, onLoadError );
		}
		
		
		public function parseScripts():void
		{
			_parsedScriptsCount = 0;
			for each(var scriptSource:IScriptSource in _scriptsToPrepare){
				parseScript( scriptSource );
			}
		}
		
		public function parseScript(scriptSource:IScriptSource):void
		{
			var feature:IFeature = scriptParser.parse(scriptSource);
			_parsedScriptsCount++;
			_scriptParsed.dispatch( feature );
			if( _parsedScriptsCount == _scriptsToPrepare.length ){
				_allScriptsParsed.dispatch();
			}
		}
		

		public function get loadedScriptsCount():int
		{
			return _loadedScriptsCount;
		}

		public function get scriptsInitialized():Signal
		{
			return _scriptsInitialized;
		}

		public function get allScriptsLoaded():Signal
		{
			return _allScriptsLoaded;
		}

		public function get scriptParsed():Signal
		{
			return _scriptParsed;
		}

		public function get allScriptsParsed():Signal
		{
			return _allScriptsParsed;
		}
	}
}