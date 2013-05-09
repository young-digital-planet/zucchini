package pl.ydp.automation.configuration.impl.scripts.parser
{
	/**
	 * Konfiguracja parsera zgodnego z językiem Gherkin.
	 */
	public class GherkinConfig
	{
		public static const FEATURE_DELIMITER:RegExp = /Feature: /;
		
		public static const SCENARIOS_DELIMITER:RegExp = /Scenario: |Scenario Outline: /;
		
		public static const SENTENCES_DELIMITER:RegExp = /^ *(Given |When |And |Then )/m;
		
		public static const SCENARIO_OUTLINE:RegExp = /(.*)Examples:(.*)/ms;
		
	}
}