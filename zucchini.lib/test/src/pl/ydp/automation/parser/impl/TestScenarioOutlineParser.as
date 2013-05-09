package pl.ydp.automation.parser.impl
{
	import org.flexunit.assertThat;
	import org.hamcrest.object.equalTo;
	
	import pl.ydp.automation.scripts.parser.impl.ScenarioOutlineParser;

	public class TestScenarioOutlineParser
	{		
		private var scenarioOutlineParser:ScenarioOutlineParser;
		
		private const OUTLINE_SOURCE:String = 
			'controlling order \n' +
			'Given there are <start> cucumbers \n' +
			'When I eat <eat> cucumbers \n' +
			'Then I should have <left> cucumbers \n' +
			
			'Examples: \n' +
			'	| start | eat | left | \n' +
			'	|  1 1   |  12  |  13   | \n' +
			'	|  21   |  22  |  23   |';
		
		
		private const FIRST_SCENARIO_OUTPUT:String =
			'( 1 ) controlling order \n' +
			'Given there are "1 1" cucumbers \n' +
			'When I eat "12" cucumbers \n' +
			'Then I should have "13" cucumbers \n';
		
		private const SECOND_SCENARIO_OUTPUT:String =
			'( 2 ) controlling order \n' +
			'Given there are "21" cucumbers \n' +
			'When I eat "22" cucumbers \n' +
			'Then I should have "23" cucumbers \n';
		
		
		[Before]
		public function setUp():void
		{
			scenarioOutlineParser = new ScenarioOutlineParser();
		}
		
		[After]
		public function tearDown():void
		{
		}
		
		
		[Test]
		public function should_parse_scenario_outline():void
		{
//			given
			
//			when
			var scenarios:Array = scenarioOutlineParser.parse( OUTLINE_SOURCE );
			
//			then
			var firstScenario:String = scenarios[0];
			var secondScenario:String = scenarios[1];
			
			assertThat( scenarios.length,  equalTo(2) );
			assertThat( firstScenario, equalTo( FIRST_SCENARIO_OUTPUT ) );
			assertThat( secondScenario, equalTo( SECOND_SCENARIO_OUTPUT ) );
		}
		
		[BeforeClass]
		public static function setUpBeforeClass():void
		{
		}
		
		[AfterClass]
		public static function tearDownAfterClass():void
		{
		}
		
		
	}
}