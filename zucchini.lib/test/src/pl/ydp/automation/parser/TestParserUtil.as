package pl.ydp.automation.parser
{
	import mockolate.mock;
	
	import org.flexunit.assertThat;
	import org.flexunit.asserts.assertFalse;
	import org.flexunit.asserts.assertTrue;
	import org.flexunit.async.Async;
	import pl.ydp.automation.scripts.parser.ParserUtil;

	public class TestParserUtil
	{		
		private var sourceWithExtraSpaces:String
		
		[Before]
		public function setUp():void
		{
			sourceWithExtraSpaces = ' a bb  ccc   ddd    a b c d   ';
		}
		
		[After]
		public function tearDown():void
		{
			sourceWithExtraSpaces = '';
		}
		
		[Test]
		public function should_remove_extra_spaces():void
		{
			var parsedSource:String = ParserUtil.removeExtraSpaces(sourceWithExtraSpaces);
			var extraSpaces:Boolean = (parsedSource.search('  ') != -1);
			assertFalse(extraSpaces);
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