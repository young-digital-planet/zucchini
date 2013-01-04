package utopia.steps
{
	import pl.ydp.automation.execution.IAutomationStep;
	import pl.ydp.automation.execution.structure.IStructure;
	import pl.ydp.automation.scripts.steps.base.Step;
	import pl.ydp.p2.modules.textinteraction.textEntry.YTextEntry;
	
	import utopia.structure.UtopiaStructure;
	
	public class FillTextInputStep extends Step implements IAutomationStep
	{
		public static const NAME:String = 'fillTextInput';
		public static const PATTERN:RegExp = /I fill in "{identifier}" with "{string}"/;
		
		internal var _textInput:String;
		internal var _value:String;
		
		[Inject]
		public var utopiaStepsUtil:UtopiaStepsUtil;
		

		[Inject]
		public var structure:IStructure;
		
		public function FillTextInputStep(resolvedPattern:RegExp)
		{
			super(resolvedPattern);
		}
		
		public function set variables(variables:Array):void
		{
			_textInput = variables[1];
			_value = variables[2];
		}
		
		public function execute(scriptName:String):void
		{
			var func:Function;
			if( _textInput.charAt(0) == '#' ){
				
				_elementNumber = parseInt( _textInput.substring( 1, _textInput.length ) );
				
				func = utopiaStepsUtil.getCheckTypeFunc( YTextEntry );
				
			}else{
				_elementNumber = 0;
				
				func = utopiaStepsUtil.getCheckIdFunc( YTextEntry, _textInput);
			}

			var utopiaStructure:UtopiaStructure = structure as UtopiaStructure;
			var element = utopiaStructure.getElement( func, _elementNumber );
				
			if( element == null ){
				
				elementNotFound();
			}else{
				(element as YTextEntry).textInput.text = _value;		
				complete( true );
			}
		}
		
		
		public function dispose():void
		{
		}
	}
}