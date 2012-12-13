package pl.ydp.automation.configuration.impl.scripts.parser
{
	/**
	 * Konfiguracja odpowiedzialna za uzyskanie 
	 * parsera zgodnego z językiem Gherkin
	 */
	public class GherkinConfig
	{
		/**
		 * Wyrażenie regularne do uzyskania opisu funkcjonalności
		 */
		public static const FEATURE_REGEXP = /Feature:(.*)/ms;
		/**
		 * Wzorzec do wykonania split'a na funkcjonalności (Feature)
		 */
		public static const SCENARIOS_DELIMITER = /Scenario:/;
		
		/**
		 * Wyrażenie regularne do uzyskania opisu scenariusza (Scenario)
		 */
		public static const SCENARIO_REGEXP = /(.*?)(Given |When |And |Then )/gms;
		/**
		 * Wzorzec do wykonania split'a na scenariuszu
		 */
		public static const SENTENCES_DELIMITER = /^ *(Given |When |And |Then )/m;
		
		
		
		public function GherkinConfig()
		{
		}
	}
}