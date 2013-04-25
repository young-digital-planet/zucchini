package utopia.steps
{
	import flash.events.Event;
	
	import pl.ydp.automation.execution.IAutomationStep;
	import pl.ydp.automation.execution.structure.IStructure;
	import pl.ydp.automation.scripts.steps.base.Step;
	import pl.ydp.p2.modules.button.YButton;
	import pl.ydp.p2.modules.button.YTwoStateButton;
	import pl.ydp.p2.modules.test.ui.YTestSwitcher;
	import pl.ydp.p2.modules.test.ui.YTestView;
	
	import utopia.structure.UtopiaStructure;
	
	public class GoToPageStep extends Step implements IAutomationStep
	{
		
		public static const NAME:String = 'pressButton';
		public static const PATTERN:RegExp = /I go to page "{number}"/;
		
		internal var _pageIndex:int;
		
		[Inject]
		public var structure:IStructure;
		
		[Inject]
		public var utopiaStepsUtil:UtopiaStepsUtil;
		
		public function GoToPageStep( resolvedPattern:RegExp )
		{
			super( resolvedPattern );
		}
		
		
		public function set variables( variables:Array ):void
		{
			_pageIndex = parseInt( variables[1] ) - 1;
		}
		
		
		
		public function execute( scriptName:String ):void
		{
			var utopiaStructure:UtopiaStructure = structure as UtopiaStructure;
			
			var func:Function = utopiaStepsUtil.getCheckTypeFunc( YTestSwitcher )
			var element = utopiaStructure.getElement( func );
			
			var btn = (element as YTestSwitcher).getButton( _pageIndex );
			utopiaStructure.test.addEventListener( YTestView.INNER_PAGE_LOADED,	onPageLoaded);
			
			(btn as YTwoStateButton).dispatchEvent( new Event(YButton.CLICK));
		}
		private function onPageLoaded( e:Event ):void
		{
			completeWithDelay( 1000, true );
		}
		
	}
}