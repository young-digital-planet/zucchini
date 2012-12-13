package pl.ydp.utils
{
	import flash.events.Event;
	import flash.events.IEventDispatcher;

	public class EventUtils
	{
		/**
		 * Zwraca funkcję redispatchującą eventy na wskazanym targecie.
		 * @example dispatcher.addEventListener( Event.COMPLETE, EventUtils.redispatch(this) );
		 */
		public static function redispatch( nTarget:IEventDispatcher, cleanup:Function = null ):Function {
			return function( e:Event ):void {
				if ( cleanup!=null ) {
					cleanup( e );
				}
				nTarget.dispatchEvent( e );
			}
		}
	}
}