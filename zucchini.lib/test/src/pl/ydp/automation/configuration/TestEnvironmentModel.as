package pl.ydp.automation.configuration
{
	import asx.array.contains;
	
	import org.flexunit.assertThat;
	import org.hamcrest.collection.hasItem;
	import pl.ydp.automation.configuration.EnvironmentModel;

	public class TestEnvironmentModel
	{		
		private var environmentModel:EnvironmentModel;
		
		[Before]
		public function setUp():void
		{
			environmentModel = new EnvironmentModel();
		}
		
		[After]
		public function tearDown():void
		{
		}
		
		[Test]
		public function should_get_filesystem_delimiter():void
		{
//			given
			environmentModel.initDelimiter();
			
//			when
			var delim:String = environmentModel.filesystemDelimiter;
			
//			then
			assertThat( ['/', '\\'], hasItem( delim ) );
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