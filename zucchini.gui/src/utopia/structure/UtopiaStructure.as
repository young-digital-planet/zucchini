package utopia.structure
{
	import flash.display.DisplayObject;
	import flash.display.IBitmapDrawable;
	
	import mx.containers.Box;
	
	import pl.ydp.automation.execution.structure.IStructure;
	import pl.ydp.automation.execution.structure.IStructureElementDescriptor;
	import pl.ydp.p2.IModule;
	import pl.ydp.p2.managers.YPopupManager;
	import pl.ydp.p2.modules.page.YPage;
	import pl.ydp.p2.modules.page.YPopupPanel;
	import pl.ydp.p2.modules.test.controller.YTestController;
	import pl.ydp.p2.modules.test.ui.YTestView;
	
	public class UtopiaStructure implements IStructure
	{
		private var _utopiaStructureComponent:UtopiaStructureComponent;
		
		
		public function UtopiaStructure()
		{
			super();
			_utopiaStructureComponent = new UtopiaStructureComponent();
		}
		
		public function getElementDescriptor(elementId:String):IStructureElementDescriptor
		{
			return null;
		}
		
		public function getElement( elementIdOrFunc:*, elementNumber:int = 0 ):*
		{
			var popupPanel:YPopupPanel = getPopupPanel();
			var popupOuterPage:YPage;
			var popupInnerPage:YPage;
			
			if( popupPanel ){
				popupOuterPage = popupPanel.getPage();
				popupInnerPage = popupPanel.getContentPage();
			}
			var pages:Array = [ test.innerPage, test.outerPage, popupInnerPage, popupOuterPage ];
			
			var element:IModule;
			if( elementNumber == 0 ){
				
				for each( var page:YPage in pages ){
					
					if( page != null ){
						
						element = page.findModule( elementIdOrFunc );
					}
					if( element ){
						break;
					}
				}
				
				/*
				element = test.outerPage.findModule( elementIdOrFunc ) ;
				if( element == null ){
					element = test.innerPage.findModule( elementIdOrFunc );
				}
				if( element == null && popupOuterPage != null){
					element = popupOuterPage.findModule( elementIdOrFunc );
				}
				if( element == null && popupInnerPage != null){
					element = popupInnerPage.findModule( elementIdOrFunc );
				}
				*/
			}else{
				
				for each( var page:YPage in pages ){
					
					if( page != null ){
						
						element = page.findModuleInContainerWithNumber( elementIdOrFunc, elementNumber );
					}
					if( element ){
						break;
					}
				}
				
				/*
				element = test.outerPage.findModuleInContainerWithNumber( elementIdOrFunc, elementNumber ) ;
				if( element == null ){
					element = test.innerPage.findModuleInContainerWithNumber( elementIdOrFunc, elementNumber );
				}
				if( element == null && popupOuterPage != null){
					element = popupOuterPage.findModuleInContainerWithNumber( elementIdOrFunc, elementNumber );
				}
				if( element == null && popupInnerPage != null){
					element = popupInnerPage.findModuleInContainerWithNumber( elementIdOrFunc, elementNumber );
				}
				*/
			}
			return element;
		}
		
		
		public function getPopupPanel():YPopupPanel
		{
			var popupPanel:YPopupPanel;
			for each( var popups:Array in YPopupManager.context){
				for each( var popup in popups ){
					if( popup is YPopupPanel ){
						popupPanel = popup;
					}
				}
			}
			return popupPanel;
		}
		
		public function get snapshotSource():IBitmapDrawable
		{
			return test;
		}
		
		public function clean():void
		{
			test.removeAllChildren();
			_utopiaStructureComponent.test = null;
		}
		
		public function get test():YTestView
		{
			return _utopiaStructureComponent.test;
		}
		
		
		
		public function loadLessonPage( lessonName:String, lessonPath:String, pageIndex:int ):void
		{
			_utopiaStructureComponent.lessonName = lessonName;
			_utopiaStructureComponent.startPage = pageIndex;
			_utopiaStructureComponent.defaultSrc = lessonPath;
			
			_utopiaStructureComponent.loadPage();
		}
		
		
		public function setCurrentIndex( index:int ):void
		{
			var controller:YTestController = test.testController as YTestController;
			controller.setCurrentIndex( 2 );
		}
		
		public function get lessonName():String
		{
			return _utopiaStructureComponent.lessonName;
		}
		
		public function get pageIndex():int
		{
			return _utopiaStructureComponent.startPage;
		}

		public function get component():DisplayObject
		{
			return _utopiaStructureComponent;
		}

		
	}
}