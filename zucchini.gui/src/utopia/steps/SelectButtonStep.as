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
			var utopiaStructure:UtopiaStructure = structure as UtopiaStructure;
			var element;
			
			if( _option.charAt(0) == '#' ){
				
				_elementNumber = parseInt( _option.substring( 1, _option.length ) );
				
				element = utopiaStructure.getElement( utopiaStepsUtil.getCheckTypeFunc( YSimpleChoice ), _elementNumber );
				
			}else{
				_elementNumber = 0;
				
				var functions:Array = [
					utopiaStepsUtil.getCheckIdFunc( YSimpleChoice, _option ), 
					utopiaStepsUtil.getCheckContentFunc( YSimpleChoice, _option ) 
				];
				
				for each( var func:Function in functions ){
					element = utopiaStructure.getElement( func, _elementNumber );
					if( element != null ){
						break;
					}
				}
			}
			
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