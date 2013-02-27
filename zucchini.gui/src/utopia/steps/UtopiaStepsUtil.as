package utopia.steps
{
	import flash.display.DisplayObject;
	
	import pl.ydp.p2.IModule;
	import pl.ydp.p2.managers.YPopupManager;
	import pl.ydp.p2.modules.page.YPage;
	import pl.ydp.p2.modules.page.YPopupPanel;
	
	import utopia.structure.UtopiaStructure;

	public class UtopiaStepsUtil
	{
		public function UtopiaStepsUtil()
		{
		}
		
		public function getElementByParam( structure:UtopiaStructure, 
											param:String, 
											elementClass:Class,
											checkTypeFunc:Function = null,
											checkIdFunc:Function = null,
											checkContentFunc:Function = null):*
		{
			var element;
			var elementNumber:int;
			
			if( checkTypeFunc == null ){
				checkTypeFunc = getCheckTypeFunc( elementClass );
			}
			if( checkIdFunc == null ){
				checkIdFunc = getCheckIdFunc( elementClass, param );
			}
			if( checkContentFunc == null ){
				checkContentFunc = getCheckContentFunc( elementClass, param );
			}
			
			if( param.charAt(0) == '#' ){
				
				elementNumber = parseInt( param.substring( 1, param.length ) );
				element = structure.getElement( checkTypeFunc, elementNumber );
				
			}else{
				elementNumber = 0;
				
				var functions:Array = [	checkIdFunc, checkContentFunc ];
				
				for each( var func:Function in functions ){
					element = structure.getElement( func, elementNumber );
					if( element != null ){
						break;
					}
				}
			}
			return element;
		}
		
		
		public function getCheckIdFunc( clazz:Class, id:String ):Function
		{
			var funcCheckId:Function = function ( mod:DisplayObject):*{
				return idIsCorrect( mod, clazz, id );
			};
			return funcCheckId;
		}
		
		public function getCheckContentFunc( clazz:Class, content:String ):Function
		{
			var funcCheckContent:Function = function ( mod:DisplayObject):*{
				return contentIsCorrect( mod, clazz, content );
			};
			return funcCheckContent;
		}
		public function getCheckTypeFunc( clazz:Class ):Function
		{
			var funcCheckType:Function = function ( mod:DisplayObject):*{
				return typeIsCorrect( mod, clazz );
			};
			return funcCheckType;
		}
		
		
		
		
		
		private function idIsCorrect( mod:DisplayObject, clazz:Class, id:String ):Boolean
		{
			var module:IModule = mod as IModule;
			return (module is clazz && module.node.@id == id);
		}
		
		private function contentIsCorrect( mod:DisplayObject, clazz:Class, content:String ):Boolean
		{
			var module:IModule = mod as IModule;
			return (module is clazz && module.node.toString() == content);
		}
		
		private function typeIsCorrect( mod:DisplayObject, clazz:Class ):Boolean
		{
			var module:IModule = mod as IModule;
			return (module is clazz);
		}
	}
}