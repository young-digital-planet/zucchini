package utopia.steps
{
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	
	import mx.core.DragSource;
	import mx.managers.DragManager;
	
	import pl.ydp.automation.execution.IAutomationStep;
	import pl.ydp.automation.execution.structure.IStructure;
	import pl.ydp.automation.scripts.steps.base.Step;
	import pl.ydp.p2.IModule;
	import pl.ydp.p2.modules.YComponent;
	import pl.ydp.p2.modules.sourcelist.ISourceListDraggable;
	import pl.ydp.p2.modules.sourcelist.ISourceListItem;
	import pl.ydp.p2.modules.sourcelist.ISourceListTarget;
	import pl.ydp.p2.modules.sourcelist.YSourceList;
	import pl.ydp.p2.modules.sourcelist.YSourceListItemBase;
	
	import utopia.structure.UtopiaStructure;
	
	public class DragSourcelistItemStep extends Step implements IAutomationStep
	{
		
		public static const NAME:String = 'dragSourcelistItem';
		public static const PATTERN:RegExp = /I drag "{string}" to "{string}"/;
		
		private var _dragSource:String;
		private var _dragTarget:String;
		
		[Inject]
		public var structure:IStructure;
		
		[Inject]
		public var utopiaStepsUtil:UtopiaStepsUtil;
		
		
		public function DragSourcelistItemStep(resolvedPattern:RegExp)
		{
			super(resolvedPattern);
		}
		
		public function set variables(variables:Array):void
		{
			_dragSource = variables[ 1 ];
			_dragTarget = variables[ 2 ];
		}
		
		public function execute(scriptName:String):void
		{
			
			var utopiaStructure:UtopiaStructure = structure as UtopiaStructure;
			
			var sourceElement:ISourceListDraggable = utopiaStepsUtil.getElementByParam( utopiaStructure, _dragSource, ISourceListDraggable );
			
			var funcCheckType:Function = function ( mod:DisplayObject):*{
				var module:IModule = mod as IModule;
				return (module is ISourceListTarget && !(module is YSourceList) );
			};
			var targetElement:ISourceListTarget = utopiaStepsUtil.getElementByParam( utopiaStructure, _dragTarget, ISourceListTarget, funcCheckType );

			
			if( sourceElement == null || targetElement == null ){
				
				elementNotFound();
			}else{
				
				dragAndDrop( sourceElement, targetElement );
				
				complete( true );
			}
			
		}
		
		private function dragAndDrop( sourceElement:ISourceListDraggable, targetElement:ISourceListTarget ):void
		{
			//operacja dragowania jest wybiórczą kopią ciała funkcji ManagedSourceList.dropSourceTarget()
			
			var dragSource:DragSource = new DragSource();
			var dragProxy:YComponent;			
			var dragView:YComponent;
			var alpha:Number;
			
//			m_manager.removeListMouseListeners();				
			
			sourceElement.doStartDrag();
			sourceElement.doMouseOut();			
			sourceElement.clean();	
			
			dragProxy = sourceElement.dragProxy;			
			dragView = sourceElement as YComponent;					
			
			dragProxy.x = 0;
			dragProxy.y = 0;
			
			dragProxy.visible = true;            
//			m_currentlyDragged = draggable as ISourceListDraggable;
			
			alpha = dragProxy.getStyle( "alpha" );
			alpha = isNaN(alpha)? 0.5: alpha;	
			
			var event:MouseEvent = new MouseEvent(MouseEvent.MOUSE_DOWN);
			
			DragManager.doDrag(dragView, dragSource, event, dragProxy, 0, 0, alpha);
			
//			m_currentlyDragged.visible = false;
			
//			m_manager.activeList = sourceList;
//			m_elementsToClean.push(m_currentlyDragged);
//			cleanUpDrag();
			
//			currentRemoteDrag = null;
			
//			----------------------------
			
//			DragManager.acceptDragDrop( sourceList );
			
//			----------------------------
			
			targetElement.dropSourceItem( sourceElement );
			targetElement.doDragExit();
			
		}
		
	}
}