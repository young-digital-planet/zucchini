package utopia.steps
{
	import flash.events.Event;
	
	import pl.ydp.automation.execution.IAutomationStep;
	import pl.ydp.automation.execution.structure.IStructure;
	import pl.ydp.automation.scripts.steps.base.Step;
	import pl.ydp.p2.modules.button.YButton;
	import pl.ydp.p2.modules.button.YTwoStateButton;
	import pl.ydp.p2.modules.simplechoice.YSimpleChoice;
	
	import utopia.structure.UtopiaStructure;
	
	public class SelectButtonStep extends Step implements IAutomationStep
	{
		public static const NAME:String = 'selectButton';
		public static const PATTERN:RegExp = /I select "{string}"/;
		
		internal var _option:String;
		
		
		[Inject]
		public var structure:IStructure;
		
		[Inject]
		public var utopiaStepsUtil:UtopiaStepsUtil;
		
		
		public function SelectButtonStep(resolvedPattern:RegExp)
		{
			super(resolvedPattern);
		}
		
		public function set variables(variables:Array):void
		{
			_option = variables[1];
		}
		
		public function execute(scriptName:String):void
		{
			var element = utopiaStepsUtil.getElementByParam( structure as UtopiaStructure, _option, YSimpleChoice );
			
			if( element == null ){
				
				elementNotFound();
			}else{
			
			var btn = ( element as YSimpleChoice ).getButton();

				(btn as YTwoStateButton).dispatchEvent( new Event(YButton.MOUSE_DOWN) );
				(btn as YTwoStateButton).dispatchEvent( new Event(YButton.MOUSE_UP) );
				(btn as YTwoStateButton).dispatchEvent( new Event(YButton.CLICK));
				(btn as YTwoStateButton).selected = true;
				(btn as YTwoStateButton).dispatchEvent( new Event(YTwoStateButton.USER_CHANGED));
				
				complete( true );
			}
		}
		
		
		public function dispose():void
		{
		}
	}
}