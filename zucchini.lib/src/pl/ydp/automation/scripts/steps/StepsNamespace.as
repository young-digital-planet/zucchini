package pl.ydp.automation.scripts.steps
{

	public class StepsNamespace
	{
		[Inject]
		public var namespaceVariables:INamespaceVariables;
	
		
		public function StepsNamespace()
		{
		}
		
		public function getRegExpForVariable( variable:String ):RegExp
		{
			var rawVariable:String;
			
			namespaceVariables.variablePattern.lastIndex = 0;
			var result:Array = namespaceVariables.variablePattern.exec(variable);
			
			rawVariable = result[1];
			
			if( namespaceVariables.patterns.hasOwnProperty( rawVariable ) ){
				return namespaceVariables.patterns[ rawVariable ];
			}
			return null;
		}

		public function get variablePattern():RegExp
		{
			return namespaceVariables.variablePattern;
		}

		public function get regexpPrefix():String
		{
			return namespaceVariables.regexpPrefix;
		}

		public function get regexpSufix():String
		{
			return namespaceVariables.regexpSufix;
		}

	
		


	}
}