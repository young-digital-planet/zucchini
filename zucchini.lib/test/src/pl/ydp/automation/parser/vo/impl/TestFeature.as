package pl.ydp.automation.parser.vo.impl
{
	import org.hamcrest.assertThat;
	import org.hamcrest.object.equalTo;
	
	import pl.ydp.automation.scripts.parser.vo.impl.Feature;
	

	public class TestFeature
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
		public function should_create_feature():void
		{
			var name:String = 'name';
			var description:String = 'description';
			var scenarios:Array = [];
			
			var feature:Feature = new Feature( name, description, scenarios );
			
			assertThat( feature.name,  equalTo( name ) );
			assertThat( feature.description,  equalTo( description ) );
			assertThat( feature.scenarios,  equalTo( scenarios ) );
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