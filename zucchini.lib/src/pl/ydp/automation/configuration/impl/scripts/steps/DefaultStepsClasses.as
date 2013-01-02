package pl.ydp.automation.configuration.impl.scripts.steps
{
	import pl.ydp.automation.scripts.steps.IStepsClasses;
	
	/**
	 * Domyślna implementacja listy kroków uwzględnianych przy parsowaniu skryptów.
	 */
	public class DefaultStepsClasses implements IStepsClasses
	{
		protected var _classes:Array;
		
		
		public function DefaultStepsClasses()
		{
			_classes = [
				
			];
		}
		
		public function get classes():Array
		{
			return _classes;
		}
	}
}