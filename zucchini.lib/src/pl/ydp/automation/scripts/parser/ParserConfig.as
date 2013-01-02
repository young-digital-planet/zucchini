package pl.ydp.automation.scripts.parser
{
	import pl.ydp.automation.configuration.impl.scripts.parser.GherkinConfig;

	/**
	 * Standaryzuje konstrukcję klasy dostarczającej
	 * konfiguracji parsera skryptów.
	 */ 
	public class ParserConfig
	{
		private static var _config:Class = GherkinConfig;
		
		public function ParserConfig()
		{
			
		}
		
		/**
		 * Wzorzec do uzyskania opisu funkcjonalności
		 */
		public static function get FEATURE_REGEXP():RegExp
		{
			return _config.FEATURE_REGEXP;
		}
		/**
		 * Wzorzec do wykonania split'a na funkcjonalności (Feature)
		 */
		public static function get SCENARIOS_DELIMITER():RegExp
		{
			return _config.SCENARIOS_DELIMITER;
		}
		/**
		 * Wzorzec do uzyskania opisu scenariusza (Scenario)
		 */
		public static function get SCENARIO_REGEXP():RegExp
		{
			return _config.SCENARIO_REGEXP;
		}
		/**
		 * Wzorzec do wykonania split'a na scenariuszu
		 */
		public static function get SENTENCES_DELIMITER():RegExp
		{
			return _config.SENTENCES_DELIMITER;
		}
		
		
		
		public static function set configClass( parserConfigClass:Class ):void
		{
			_config = parserConfigClass;
		}
		
	}
}