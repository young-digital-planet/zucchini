package pl.ydp.automation.scripts.steps.impl
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.controls.Button;
	
	import pl.ydp.automation.execution.IAutomationStep;
	import pl.ydp.automation.execution.structure.IStructure;
	import pl.ydp.automation.scripts.steps.StepResult;
	import pl.ydp.automation.scripts.steps.base.Step;
	
	/**
	 * Klasa demonstracyjna.
	 * Prezentuje wzorzec implementacji pojedynczego kroku.
	 */
	public class PressButtonStep extends Step implements IAutomationStep
	{
		
		public static const NAME:String = 'pressButton';
		public static const PATTERN:RegExp = /I press {identifier}/;
		
		private var _buttonId:String;
		
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
			var element = structure.getElement( _buttonId );
			
			(element as Button).dispatchEvent( new Event(MouseEvent.CLICK));
			
			complete( true );
		}
		
	}
}