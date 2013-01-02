package pl.ydp.automation.configuration.impl.scripts.parser
{
	/**
	 * Konfiguracja parsera zgodnego z językiem Gherkin.
	 */
	public class GherkinConfig
	{
		public static const FEATURE_REGEXP:RegExp = /Feature:(.*)/ms;
		
		public static const SCENARIOS_DELIMITER:RegExp = /Scenario:/;
		
		public static const SCENARIO_REGEXP:RegExp = /(.*?)(Given |When |And |Then )/gms;
		
		public static const SENTENCES_DELIMITER:RegExp = /^ *(Given |When |And |Then )/m;
		
		
		public function GherkinConfig()
		{
		}
	}
}