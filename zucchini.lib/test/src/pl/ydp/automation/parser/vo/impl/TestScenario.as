package pl.ydp.automation.parser.vo.impl
{
	import org.flexunit.asserts.assertEquals;
	
	import pl.ydp.automation.scripts.parser.vo.impl.Scenario;


	public class TestScenario
	{		
		private var source:String =
			'Scenario: 	Some determinable business situation \n' +
					      'Given some And precondition \n' +
					      'And some other precondition \n' +
					      'When some action by the actor \n' +
					      ' And some other action \n' +
					      'And yet another action \n' +
					      '   Then some testable outcome is achieved \n' +
					      'And something else we can check happens too \n';
		
		private var scenario:Scenario;
			
		[Before]
		public function setUp():void
		{
			scenario = new Scenario( source );
		}
		
		[After]
		public function tearDown():void
		{
			scenario = null;
		}
		
		[Test]
		public function should_get_seven_sentences():void
		{
			assertEquals( scenario.sentences.length, 7 );
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