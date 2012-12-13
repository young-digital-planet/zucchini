package pl.ydp.automation.scripts.events
{
	import flash.events.Event;
	
	import pl.ydp.automation.scripts.parser.vo.IFeature;
	
	public class ScriptEvent extends Event
	{
		public static const SCRIPT_PARSED:String = 'scriptParsed';
		
		private var _feature:IFeature;
		
		public function ScriptEvent(type:String, feature:IFeature, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_feature = feature;
		}
		
		public function get feature()
		{
			return _feature;
		}

	}
}