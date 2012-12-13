package utopia
{
	import flash.display.DisplayObjectContainer;
	
	import pl.ydp.automation.configuration.impl.context.DefaultAutomationAppContext;
	import utopia.steps.UtopiaStepsUtil;
	
	public class UtopiaAppContext extends DefaultAutomationAppContext
	{
		public function UtopiaAppContext(contextView:DisplayObjectContainer=null)
		{
			super(contextView);
		}
		
		
		override public function startup():void
		{
			injector.mapSingleton( UtopiaStepsUtil );
			
			super.startup();
		}
	}
}