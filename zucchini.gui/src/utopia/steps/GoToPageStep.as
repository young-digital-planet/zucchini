package utopia.steps
{
	import com.yauthor.feedback.YUserActionEvent;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	
	import pl.ydp.automation.execution.IAutomationContext;
	import pl.ydp.automation.execution.IAutomationStep;
	import pl.ydp.automation.execution.structure.IStructure;
	import pl.ydp.automation.execution.structure.IStructureElementDescriptor;
	import pl.ydp.automation.execution.structure.impl.utopia.UtopiaStructureComponent;
	import pl.ydp.automation.scripts.parser.vo.ISentence;
	import pl.ydp.automation.scripts.parser.vo.impl.Sentence;
	import pl.ydp.automation.scripts.steps.StepResult;
	import pl.ydp.automation.scripts.steps.base.Step;
	import pl.ydp.p2.IModule;
	import pl.ydp.p2.modules.YActivity;
	import pl.ydp.p2.modules.button.YButton;
	import pl.ydp.p2.modules.button.YTwoStateButton;
	import pl.ydp.p2.modules.simplechoice.YSimpleChoice;
	import pl.ydp.p2.modules.test.ITestSection;
	import pl.ydp.p2.modules.test.controller.YTestController;
	import pl.ydp.p2.modules.test.ui.YTestSwitcher;
	import pl.ydp.p2.modules.test.ui.YTestView;
	import pl.ydp.p2.modules.textinteraction.textEntry.YTextEntry;
	
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
			var utopiaStructure:UtopiaStructureComponent = structure as UtopiaStructureComponent;
			
			var func:Function = utopiaStepsUtil.getCheckTypeFunc( YTestSwitcher )
			var element = utopiaStructure.getElement( func );
			
			var btn = (element as YTestSwitcher).getButton( _pageIndex );
			utopiaStructure.test.addEventListener( YTestView.INNER_PAGE_LOADED,	onPageLoaded);
			
			(btn as YTwoStateButton).dispatchEvent( new Event(YButton.CLICK));
		}
		private function onPageLoaded( e:Event ):void
		{
			completeWithDelay( 1000,  createResult( true ) );
		}
		
		public function dispose():void
		{
			
		}
		
	}
}