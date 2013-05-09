package pl.ydp.automation.scripts.parser.vo.impl
{
	
	import mx.collections.ArrayCollection;
	import mx.utils.StringUtil;
	
	import pl.ydp.automation.configuration.impl.scripts.parser.GherkinConfig;
	import pl.ydp.automation.execution.AutomationScript;
	import pl.ydp.automation.scripts.parser.ParserConfig;
	import pl.ydp.automation.scripts.parser.impl.ScenarioOutlineParser;
	import pl.ydp.automation.scripts.parser.vo.IFeature;

	/**
	 * Reprezentacja pojedynczego skryptu składającego się z opisu
	 * oraz listy scenariuszy.
	 */
	public class Feature implements IFeature
	{
		/**
		 * Nazwa funkcjonalności, tożsama z nazwą pliku.
		 */
		private var _name:String;
		/**
		 * Opis funkcjonalności do przetestowania.
		 */
		private var _description:String;
		/**
		 * Lista obiektów typu Scenario (_scenariosParts zmapowane na obiekty).
		 */
		private var _scenarios:Array;
		
		
		public function Feature(name:String, parsedDescription:String, parsedScenarios:Array)
		{
			_name = name;
			_description = parsedDescription;
			_scenarios = parsedScenarios;
		}
	
		
		public function get description():String
		{
			return _description;
		}

		public function get scenarios():Array
		{
			return _scenarios;
		}

		public function get name():String
		{
			return _name;
		}
	}
}