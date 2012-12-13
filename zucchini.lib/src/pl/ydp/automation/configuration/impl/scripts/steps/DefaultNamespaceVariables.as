package pl.ydp.automation.configuration.impl.scripts.steps
{
	import pl.ydp.automation.scripts.steps.INamespaceVariables;
	
	public class DefaultNamespaceVariables implements INamespaceVariables
	{
		private const _variablePattern:RegExp = /{(\w+)}/g;
		private const _regexpPrefix:String = '(';
		private const _regexpSufix:String = ')';
		
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

		public function get regexpPrefix():String
		{
			return _regexpPrefix;
		}

		public function get regexpSufix():String
		{
			return _regexpSufix;
		}
		
		
	}
}