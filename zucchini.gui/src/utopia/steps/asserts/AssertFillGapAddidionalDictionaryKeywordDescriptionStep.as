package utopia.steps.asserts
{
	import pl.ydp.automation.execution.IAutomationStep;
	import pl.ydp.automation.execution.structure.IStructure;
	import pl.ydp.automation.scripts.steps.base.Step;
	import pl.ydp.p2.IModule;
	import pl.ydp.p2.modules.dictionary.extended.service.YDictionaryPagesFactory;
	import pl.ydp.p2.modules.edit.YEditInteraction;
	import pl.ydp.p2.modules.page.YInnerPage;
	import pl.ydp.p2.modules.page.YPopupDictionary;
	import pl.ydp.p2.modules.page.YPopupPanel;
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
	public class AssertFillGapAddidionalDictionaryKeywordDescriptionStep extends Step implements IAutomationStep
	{
		public static const NAME:String = 'assertFillGapAddidionalDictionaryKeywordDescription';
		public static const PATTERN:RegExp = /I should see "{string}" in additional dictionary description/;
		
		internal var _value:String;
		
		[Inject]
		public var utopiaStepsUtil:UtopiaStepsUtil;
		
		[Inject]
		public var structure:IStructure;
		
		public function AssertFillGapAddidionalDictionaryKeywordDescriptionStep(resolvedPattern:RegExp)
		{
			super(resolvedPattern); 
		}
		
		public function set variables(variables:Array):void
		{
			_value = variables[ 1 ];
		}
		
		public function execute(scriptName:String):void
		{
			var popupPanel:YPopupPanel = (structure as UtopiaStructure).getPopupPanel();
			var innerPage:YInnerPage;
			
			if( popupPanel ){
				
				var dictionaryPopup:YPopupDictionary = popupPanel.popupPage as YPopupDictionary;
				innerPage = dictionaryPopup.innerPage;
			}
			var keywordId:String = YDictionaryPagesFactory.DESCRIPTION_ID;
			var func:Function = utopiaStepsUtil.getCheckIdFunc( YEditInteraction, keywordId );
			var editInteraction:YEditInteraction = innerPage.findModule( func ) as YEditInteraction;
			
			if( editInteraction == null ){
				
				elementNotFound();
			}else{
				
				var correct:Boolean = false;
				
				if( editInteraction.text == _value ){
					correct = true;
				}
				
				complete( correct );
			}
			
		}
	}
}