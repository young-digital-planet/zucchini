package pl.ydp.automation.parser.vo
{
	import mockolate.mock;
	
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertTrue;
	import org.hamcrest.assertThat;
	import org.hamcrest.mxml.collection.InArray;
	
	import pl.ydp.automation.scripts.parser.vo.impl.Feature;
	

	public class TestFeature
	{		
		private var source:String = 
			'Feature:  Some terse yet descriptive text of what is desired \n' +
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
		
		private var feature:Feature;
		private var FEATURE_NAME:String = 'feature1';
		
		[Before]
		public function setUp():void
		{
			feature = new Feature( FEATURE_NAME, source );
		}
		
		[After]
		public function tearDown():void
		{
			feature = null;
		}
		
		[Test]
		public function should_get_two_scenarios():void
		{
			assertEquals(feature.scenarios.length,  2 );
		}
		
		[Test]
		public function should_get_feature_name():void
		{
			assertEquals(feature.name,  FEATURE_NAME );
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