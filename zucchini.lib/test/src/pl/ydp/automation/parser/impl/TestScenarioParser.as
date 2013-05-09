package pl.ydp.automation.parser.impl
{
	import org.flexunit.assertThat;
	import org.hamcrest.object.equalTo;
	
	import pl.ydp.automation.scripts.parser.impl.ScenarioParser;
	import pl.ydp.automation.scripts.parser.vo.impl.Scenario;

	public class TestScenarioParser
	{		
		private var scenarioParser:ScenarioParser;
		
		private const SOURCE:String =
			'Some determinable business situation \n' +
			'Given some And precondition \n' +
			'And some other precondition \n' +
			'When some action by the actor \n' +
			' And some other action \n' +
			'And yet another action \n' +
			'   Then some testable outcome is achieved \n' +
			'And something else we can check happens too \n';
		
		private const DESCRIPTION:String = 
			'Some determinable business situation';
		
		
		[Before]
		public function setUp():void
		{
			scenarioParser = new ScenarioParser();
		}
		
		[After]
		public function tearDown():void
		{
		}
		
		[Test]
		public function should_parse_scenario():void
		{
			var scenario:Scenario = scenarioParser.parse( SOURCE );
			
			assertThat( scenario.description,  equalTo( DESCRIPTION ) );
			assertThat( scenario.sentences.length, equalTo( 7 ) );
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