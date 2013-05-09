package pl.ydp.automation.parser.vo.impl
{
	import org.flexunit.assertThat;
	import org.hamcrest.object.equalTo;
	
	import pl.ydp.automation.scripts.parser.vo.impl.Sentence;

	public class TestSentence
	{		
		private const SOURCE:String = 
			'New sentence source \n';
		
		[Before]
		public function setUp():void
		{
		}
		
		[After]
		public function tearDown():void
		{
		}
		
		[Test]
		public function should_create_sentence():void
		{
			var sentence:Sentence = new Sentence( SOURCE );
			
			assertThat( sentence.source, equalTo( SOURCE ) );
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