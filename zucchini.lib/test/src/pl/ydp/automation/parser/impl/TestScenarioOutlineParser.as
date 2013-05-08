package pl.ydp.automation.parser.impl
{
	import org.flexunit.assertThat;
	import org.hamcrest.object.equalTo;
	
	import pl.ydp.automation.scripts.parser.impl.ScenarioOutlineParser;
	import pl.ydp.automation.scripts.parser.vo.impl.Scenario;

	public class TestScenarioOutlineParser
	{		
		private var scenarioOutline:ScenarioOutlineParser;
		
		private var outlineSource:String = 
			'controlling order \n' +
			'Given there are <start> cucumbers \n' +
			'When I eat <eat> cucumbers \n' +
			'Then I should have <left> cucumbers \n' +
			
			'Examples: \n' +
			'	| start | eat | left | \n' +
			'	|  1 1   |  12  |  13   | \n' +
			'	|  21   |  22  |  23   |';
		
		
		private var firstScenarioOutput:String =
			'( 1 ) controlling order \n' +
			'Given there are "1 1" cucumbers \n' +
			'When I eat "12" cucumbers \n' +
			'Then I should have "13" cucumbers \n';
		
		private var secondScenarioOutput:String =
			'( 2 ) controlling order \n' +
			'Given there are "21" cucumbers \n' +
			'When I eat "22" cucumbers \n' +
			'Then I should have "23" cucumbers \n';
		
		
		[Before]
		public function setUp():void
		{
		}
		
		[After]
		public function tearDown():void
		{
		}
		
		
		[Test]
		public function should_parse_scenario_outline():void
		{
//			given
			scenarioOutline = new ScenarioOutlineParser( outlineSource );
			
//			when
			scenarioOutline.parse();
			
//			then
			var scenarios:Array = scenarioOutline.scenariosSources;
			var firstScenario:String = scenarios[0];
			var secondScenario:String = scenarios[1];
			
			assertThat( scenarios.length,  equalTo(2) );
			assertThat( firstScenario, equalTo( firstScenarioOutput ) );
			assertThat( secondScenario, equalTo( secondScenarioOutput ) );
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