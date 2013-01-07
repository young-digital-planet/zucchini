package utopia.steps.asserts
{
	import pl.ydp.automation.execution.IAutomationStep;
	import pl.ydp.automation.execution.structure.IStructure;
	import pl.ydp.automation.scripts.steps.base.Step;
	import pl.ydp.p2.IModule;
	import pl.ydp.p2.modules.sourcelist.ISourceListDraggable;
	import pl.ydp.p2.modules.sourcelist.YSimpleSourceListItem;
	import pl.ydp.p2.modules.textinteraction.imageEntry.YImageEntryInteraction;
	import pl.ydp.p2.modules.textinteraction.textEntry.YTextEntry;
	
	import utopia.steps.UtopiaStepsUtil;
	import utopia.structure.UtopiaStructure;
	
	/**
	 * Krok weryfikujący kroki:
	 * - FillTextInputStep
	 * - DragSourcelistItemStep
	 */
	public class AssertFillGapStep extends Step implements IAutomationStep
	{
		public static const NAME:String = 'assertFillTextInput';
		public static const PATTERN:RegExp = /I should see "{string}" in the "{string}" element/;
		
		internal var _value:String;
		/**
		 * Reprezentacja YTextEntry lub YImageEntryInteraction
		 */
		internal var _gap:String;
		
		
		[Inject]
		public var utopiaStepsUtil:UtopiaStepsUtil;
		
		[Inject]
		public var structure:IStructure;
		
		public function AssertFillGapStep(resolvedPattern:RegExp)
		{
			super(resolvedPattern); 
		}
		
		public function set variables(variables:Array):void
		{
			_value = variables[ 1 ];
			_gap = variables[ 2 ];
		}
		
		public function execute(scriptName:String):void
		{
			var textEntryElement:YTextEntry = utopiaStepsUtil.getElementByParam( structure as UtopiaStructure, _gap, YTextEntry );
			var imageEntryElement:YImageEntryInteraction = utopiaStepsUtil.getElementByParam( structure as UtopiaStructure, _gap, YImageEntryInteraction );
			
			if( textEntryElement == null && imageEntryElement == null ){
			
				elementNotFound();
			}else{
				
				var correct:Boolean = false;
				
				if( textEntryElement != null ){
					
					if( textEntryElement.textInput.text == _value ){
						correct = true;
					}
					
				}else if( imageEntryElement != null ){
					
					
					if( ( imageEntryElement.sourceListItem as YSimpleSourceListItem ).node.toString() == _value ){
						correct = true;
					}
					
				}
				
				complete( correct );
				
			}
			
			
		}
	}
}