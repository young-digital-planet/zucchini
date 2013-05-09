package pl.ydp.automation.parser.impl
{
	import org.flexunit.assertThat;
	import org.hamcrest.object.equalTo;
	
	import pl.ydp.automation.scripts.parser.impl.FeatureParser;
	import pl.ydp.automation.scripts.parser.vo.impl.Feature;

	public class TestFeatureParser
	{	
		private const SIMPLE_SOURCE:String = 
			'Feature: Some terse yet descriptive text of what is desired \n' +
			' In order to realize a named business value \n' +
			'As an explicit system actor \n' +
			'I want to gain some beneficial outcome which furthers the goal \n' +
			
			'Scenario: Some determinable business situation \n' +
			'Given some And precondition \n' +
			'  And some other precondition \n' +
			' When some action by the actor \n' +
			'  And some other action \n' +
			'  And yet another action \n' +
			' Then some testable outcome is achieved \n' +
			'  And something else we can check happens too \n' +
			
			'  Scenario: A different situation \n' +
			' Given some precondition \n' +
			'  And some other precondition \n' +
			'  When some action by the actor \n' +
			' And some other action \n' +
			'  And yet another action \n' +
			' Then some testable outcome is achieved \n' +
			'  And something else we can check happens too \n';
		
		private const SIMPLE_DESCRIPTION:String = 
			'Feature: Some terse yet descriptive text of what is desired \n' +
			' In order to realize a named business value \n' +
			'As an explicit system actor \n' +
			'I want to gain some beneficial outcome which furthers the goal';
		
		private var OUTLINE_SOURCE:String = 
			'Feature: Some terse yet descriptive text of what is desired \n' +
			' In order to realize a named business value \n' +
			
			'Scenario Outline: controlling order \n' +
			'Given there are <start> cucumbers \n' +
			' When I eat <eat> cucumbers \n' +
			' Then I should have <left> cucumbers \n' +
			
			'Examples: \n' +
			'	| start | eat | left | \n' +
			'	|  12   |  5  |  7   | \n' +
			'	|  12   |  5  |  7   |';
		
		private const OUTLINE_DESCRIPTION:String = 
			'Feature: Some terse yet descriptive text of what is desired \n' +
			' In order to realize a named business value';
		
		
		private var featureParser:FeatureParser;
		
		[Before]
		public function setUp():void
		{
			featureParser = new FeatureParser();
			
			
		}
		
		[After]
		public function tearDown():void
		{
		}
		
		
		[Test]
		public function should_parse_simple_feature():void
		{
			var name:String = 'name';
			
			var feature:Feature = featureParser.parse( name, SIMPLE_SOURCE );
			
			assertThat( feature.name,  equalTo( name ) );
			assertThat( feature.scenarios.length, equalTo( 2 ) );
			assertThat( feature.description, equalTo( SIMPLE_DESCRIPTION ) );
		}
		
		[Test]
		public function should_parse_feature_with_outline():void
		{
			var name:String = 'name';
			
			var feature:Feature = featureParser.parse( name, OUTLINE_SOURCE );
			
			assertThat( feature.name,  equalTo( name ) );
			assertThat( feature.scenarios.length, equalTo( 2 ) );
			assertThat( feature.description, equalTo( OUTLINE_DESCRIPTION ) );
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