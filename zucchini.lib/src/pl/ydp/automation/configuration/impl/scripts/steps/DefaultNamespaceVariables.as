package pl.ydp.automation.configuration.impl.scripts.steps
{
	import pl.ydp.automation.scripts.steps.INamespaceVariables;
	
	/**
	 * Domyślna implementacja reguł syntaktyki dla pojedynczego kroku.
	 */
	public class DefaultNamespaceVariables implements INamespaceVariables
	{
		private const _variablePattern:RegExp = /{(\w+)}/g;
		
		private var _patterns:Object;
		
		public function DefaultNamespaceVariables()
		{
			_patterns = {
				identifier: /#?\w+/,
				string: /.+/,
				number: /\d+/
			};
		}
		
		public function get patterns():Object
		{
			return _patterns;
		}

		public function get variablePattern():RegExp
		{
			return _variablePattern;
		}

	}
}