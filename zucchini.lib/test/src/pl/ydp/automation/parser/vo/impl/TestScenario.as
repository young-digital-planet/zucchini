package pl.ydp.automation.parser.vo.impl
{
	import org.flexunit.assertThat;
	import org.hamcrest.object.equalTo;
	
	import pl.ydp.automation.scripts.parser.vo.impl.Scenario;


	public class TestScenario
	{		
		[Before]
		public function setUp():void
		{
		}
		
		[After]
		public function tearDown():void
		{
		}
		
		[Test]
		public function should_create_scenario():void
		{
			var description:String = 'description';
			var sentences:Array = [];
			
			var scenario:Scenario = new Scenario( description, sentences );
			
			assertThat( scenario.description, equalTo( description ) );
			assertThat( scenario.sentences, equalTo( sentences ) );
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