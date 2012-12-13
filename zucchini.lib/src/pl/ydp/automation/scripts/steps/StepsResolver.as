package pl.ydp.automation.scripts.steps
{

	/**
	 * Przechowuje obiekt mapujący nazwę Step'a na regexp'a
	 * na podstawie wstrzykniętej obiektu z mapowaniami (StepsNamespace)
	 */
	public class StepsResolver
	{
		[Inject]
		public var stepsNamespace:StepsNamespace;
		[Inject]
		public var stepsRegistry:StepsRegistry;
		
		private var _map:Object = {};
		
		public function StepsResolver()
		{
		}
		
		
		[PostConstruct]
		public function resolvePatterns():void
		{
			for each( var stepClass:Class in stepsRegistry.steps ){
				_map[ stepClass.NAME ]  = resolvePattern( stepClass.PATTERN );
			}
		}
		
		/**
		 * Parsuje wzorzec stepu i konwertuje go na wyrażenia regularne
		 * na podstawie wstrzykniętego StepsNamspace'a
		 */
		public function resolvePattern( stepPattern:RegExp ):RegExp
		{
			var patternSource = stepPattern.source;
			var variables:Array = patternSource.match( stepsNamespace.variablePattern );
			
			for (var i:int = 0; i < variables.length; i++){
				
				var regExp:RegExp = stepsNamespace.getRegExpForVariable( variables[i] );
				
				if( regExp != null ){
					
					patternSource = patternSource.replace(
						variables[i], 
						stepsNamespace.regexpPrefix + regExp.source  + stepsNamespace.regexpSufix
					);
				}
			}
			var newPattern:RegExp = new RegExp(patternSource);
			return newPattern;
		}
		
		
		
		public function getResolved( stepName:String ):RegExp
		{
			if( _map.hasOwnProperty( stepName ) ){
				return _map[stepName];
			}
			return null;
		}
	}
}