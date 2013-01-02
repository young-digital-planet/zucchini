package pl.ydp.automation.scripts.steps
{

	/**
	 * Przechowuje obiekt mapujący nazwę Step'a na regexp'a
	 * na podstawie wstrzykniętej obiektu z mapowaniami (StepsNamespace)
	 */
	public class StepsResolver
	{
		[Inject]
		public var namespaceVariables:INamespaceVariables;
		[Inject]
		public var stepsRegistry:StepsRegistry;
		
		private const _regexpPrefix:String = '(';
		private const _regexpSufix:String = ')';
		
		/**
		 * Wynikowe wzorce dla kroków.
		 */
		private var _resolvedPatterns:Object = {};
		
		public function StepsResolver()
		{
		}
		
		
		[PostConstruct]
		public function resolvePatterns():void
		{
			for each( var stepClass:Class in stepsRegistry.steps ){
				_resolvedPatterns[ stepClass.NAME ]  = resolvePattern( stepClass.PATTERN );
			}
		}
		
		/**
		 * Parsuje wzorzec stepu i konwertuje go na wyrażenia regularne
		 * na podstawie wstrzykniętego StepsNamspace'a
		 */
		public function resolvePattern( stepPattern:RegExp ):RegExp
		{
			var patternSource = stepPattern.source;
			var variables:Array = patternSource.match( namespaceVariables.variablePattern );
			
			for (var i:int = 0; i < variables.length; i++){
				
				var regExp:RegExp = getRegExpForVariable( variables[i] );
				
				if( regExp != null ){
					
					patternSource = patternSource.replace(
						variables[i], 
						_regexpPrefix + regExp.source  + _regexpSufix
					);
				}
			}
			var newPattern:RegExp = new RegExp(patternSource);
			return newPattern;
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
		
		
		public function getResolved( stepName:String ):RegExp
		{
			if( _resolvedPatterns.hasOwnProperty( stepName ) ){
				return _resolvedPatterns[stepName];
			}
			return null;
		}
	}
}