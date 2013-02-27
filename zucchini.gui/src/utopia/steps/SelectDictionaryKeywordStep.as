package utopia.steps
{
	import mx.collections.ArrayCollection;
	import mx.events.ListEvent;
	
	import pl.ydp.automation.execution.IAutomationStep;
	import pl.ydp.automation.execution.structure.IStructure;
	import pl.ydp.automation.scripts.steps.base.Step;
	import pl.ydp.p2.managers.YPopupManager;
	import pl.ydp.p2.modules.dictionary.controller.YDictionaryItemInfo;
	import pl.ydp.p2.modules.dictionary.ui.YDictionaryItemList;
	import pl.ydp.p2.modules.dictionary.ui.YDictionarySearch;
	import pl.ydp.p2.modules.page.YPage;
	import pl.ydp.p2.modules.page.YPopupPanel;
	
	import utopia.structure.UtopiaStructure;
	
	public class SelectDictionaryKeywordStep extends Step implements IAutomationStep
	{
		
		public static const NAME:String = 'pressDictionaryKeyword';
		public static const PATTERN:RegExp = /I press keyword "{identifier}" in dictionary/;
		
		private var _keyword:String;
		
		[Inject]
		public var structure:IStructure;
		
		[Inject]
		public var utopiaStepsUtil:UtopiaStepsUtil;
		
		
		public function SelectDictionaryKeywordStep( resolvedPattern:RegExp )
		{
			super( resolvedPattern );
		}
		
		
		public function set variables( variables:Array ):void
		{
			_keyword = variables[1];
		}
		
		public function dispose():void
		{
			
		}
		
		public function execute( scriptName:String ):void
		{
			var element = structure.getElement( utopiaStepsUtil.getCheckTypeFunc( YDictionaryItemList ) );
			
			var itemIndex:int = -1;
			if( element != null ){
				var items:ArrayCollection = (element as YDictionaryItemList).list.dataProvider as ArrayCollection;
				var indexToSet:int = 0;
				for each( var item:YDictionaryItemInfo in items ){
					if( item.title == _keyword ){
						itemIndex = item.index;
					}
				}
			}
			if( itemIndex == -1 ){
				
				elementNotFound();
			}else{
				
				(element as YDictionaryItemList).dictionaryController.currentIndex = itemIndex;
				
				completeWithDelay( 1000, createResult( true ) );
			}
		}
	}
}
