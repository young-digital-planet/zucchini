package utopia.steps
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.controls.Button;
	
	import pl.ydp.automation.execution.IAutomationStep;
	import pl.ydp.automation.execution.structure.IStructure;
	import pl.ydp.automation.scripts.steps.StepResult;
	import pl.ydp.automation.scripts.steps.base.Step;
	import pl.ydp.p2.modules.button.YButton;
	
	import utopia.structure.UtopiaStructure;
	
	public class PressButtonStep extends Step implements IAutomationStep
	{
		
		public static const NAME:String = 'pressButton';
		public static const PATTERN:RegExp = /I press "{identifier}"/;
		
		private var _buttonId:String;
		
		[Inject]
		public var utopiaStepsUtil:UtopiaStepsUtil;
		
		[Inject]
		public var structure:IStructure;
		
		
		public function PressButtonStep( resolvedPattern:RegExp )
		{
			super( resolvedPattern );
		}
		
		
		public function set variables( variables:Array ):void
		{
			_buttonId = variables[1];
		}
		
		public function dispose():void
		{
			
		}
		
		public function execute( scriptName:String ):void
		{
			var element = utopiaStepsUtil.getElementByParam( structure as UtopiaStructure, _buttonId, YButton );
			
			(element as YButton).dispatchEvent( new Event( YButton.CLICK ) );
			(element as YButton)._doAction();
			
			completeWithDelay( 2000, createResult( true ) );
		}
		
	}
}
