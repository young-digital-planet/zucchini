package pl.ydp.automation.configuration.impl.scripts.steps
{
	import com.carlcalderon.arthropod.Debug;
	
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
		
		protected function logSteps():void
		{
			var stepsOutput:String;
			stepsOutput = '-----STEPS START-----';
			for each( var clazz:Class in _classes ){
				stepsOutput += '\n' + clazz.NAME + '\n' + clazz.PATTERN + '\n';
			}
			stepsOutput += '-----STEPS END-----';
			Debug.log( stepsOutput );
		}
	}
}