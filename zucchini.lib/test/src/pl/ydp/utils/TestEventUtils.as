package pl.ydp.utils
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import flexunit.framework.Assert;
	
	import org.flexunit.assertThat;
	import org.hamcrest.core.not;
	import org.hamcrest.object.equalTo;
	import org.hamcrest.object.isTrue;
	import org.hamcrest.object.sameInstance;
	import pl.ydp.utils.EventUtils;
	
	public class TestEventUtils {
		[Test]
		public function should_redispatch_clone_event():void {
			var evt:EventDispatcher = new EventDispatcher();
			var cEvt:Event = new Event( Event.COMPLETE );
			var called:Boolean = false;
			evt.addEventListener( Event.COMPLETE, function(e:Event):void {
				called = true;
				assertThat( e.type, equalTo(Event.COMPLETE) );
			} );
			
			EventUtils.redispatch( evt )( cEvt );
			assertThat( called, isTrue() );
		}
		
		[Test]
		public function should_call_cleanup():void {
			var evt:EventDispatcher = new EventDispatcher();
			var cEvt:Event = new Event( Event.COMPLETE );
			var called:Boolean = false;
			
			EventUtils.redispatch( evt,function(e:Event):void {
				called = true;
				assertThat( e, sameInstance(cEvt) );
			} )( cEvt );
			
			assertThat( called, isTrue() );
		}
	}
}