package utopia.steps
{
	import flash.display.DisplayObject;
	
	import pl.ydp.p2.IModule;

	public class UtopiaStepsUtil
	{
		public function UtopiaStepsUtil()
		{
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