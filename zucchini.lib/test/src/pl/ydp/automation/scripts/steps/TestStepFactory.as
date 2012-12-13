package pl.ydp.automation.scripts.steps
{
	import flash.events.Event;
	
	import mockolate.mock;
	import mockolate.prepare;
	import mockolate.strict;
	
	import org.flexunit.assertThat;
	import org.flexunit.async.Async;
	import org.hamcrest.object.isFalse;
	import org.hamcrest.object.isTrue;
	
	import pl.ydp.automation.scripts.parser.vo.ISentence;
	import pl.ydp.automation.scripts.parser.vo.impl.Sentence;
	import pl.ydp.automation.scripts.steps.base.Step;
	import pl.ydp.automation.scripts.steps.StepFactory;

	public class TestStepFactory
	{		
		
		private var stepFactory:StepFactory;
		
		private var regExp1:RegExp = /press \w+ button/;
		private var regExp2:RegExp = /press \w+  button/;
		
		private var sentence:ISentence;
		private const SENTENCE_SOURCE:String = 'press btn_1 button';
		
		
		[Before]
		public function setUp():void
		{
			stepFactory = new StepFactory();
			sentence = strict( Sentence );
			mock( sentence ).getter( 'source' ).returns( SENTENCE_SOURCE );
		}
		
		[After]
		public function tearDown():void
		{
		}
		
		[Test]
		public function should_pass_regexp():void
		{
			var match:Boolean = stepFactory.checkPattern( regExp1, sentence );
			assertThat( match, isTrue() );
			
		}
		
		[Test]
		public function should_fail_regexp():void
		{
			var match:Boolean = stepFactory.checkPattern( regExp2, sentence );
			assertThat( match, isFalse() );
		}
		
		
		
		[BeforeClass(async, timeout=100)]
		public static function setUpBeforeClass():void
		{
			Async.proceedOnEvent(TestStepFactory,
				prepare( Sentence ),
				Event.COMPLETE);
		}
		
		[AfterClass]
		public static function tearDownAfterClass():void
		{
		}
		
		
	}
}