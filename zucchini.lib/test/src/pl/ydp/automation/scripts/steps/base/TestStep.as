package pl.ydp.automation.scripts.steps.base
{
	import flash.events.Event;
	
	import mockolate.mock;
	import mockolate.nice;
	import mockolate.prepare;
	import mockolate.received;
	import mockolate.strict;
	
	import org.flexunit.assertThat;
	import org.flexunit.async.Async;
	import org.hamcrest.object.equalTo;
	import org.hamcrest.object.notNullValue;
	import org.osflash.signals.Signal;
	import org.osflash.signals.utils.proceedOnSignal;
	
	import pl.ydp.automation.execution.ExecutionModel;
	import pl.ydp.automation.execution.structure.IStructure;
	import pl.ydp.automation.execution.structure.IStructureElementDescriptor;
	import pl.ydp.automation.scripts.parser.vo.ISentence;
	import pl.ydp.automation.scripts.steps.StepResult;
	import pl.ydp.automation.scripts.steps.base.Step;

	public class TestStep
	{		
		private var sentence:ISentence;
		private var step:Step;

		
		private const SENTENCE_SOURCE:String = 'press btn_1 button';
		private const PATTERN:RegExp = /.*/;
		
		[Before]
		public function setUp():void
		{
//			given
			sentence = strict( ISentence );
			mock( sentence ).getter( 'source' ).returns( SENTENCE_SOURCE );
			
			
			step = new Step( PATTERN );
		}
		
		[After]
		public function tearDown():void
		{
			
		}
		
		
		[Test]
		public function should_get_pattern():void
		{
			assertThat( step.resolvedPattern, equalTo( PATTERN ) );
		}
		
		[Test]
		public function should_get_sentence():void
		{
//			when
			step.initialize( sentence );
			
//			then
			assertThat( step.sentence, notNullValue() );
			assertThat( step.sentence.source, equalTo( SENTENCE_SOURCE ) );
		}
		
		
		
		[Test(async)]
		public function should_dispach_by_descriptor():void
		{
//			given
			var event:Event = new Event( 'eventType' );
			var signal:Signal = new Signal();
			var stepResult:StepResult = nice( StepResult );
			var elementId:String = 'elementId';
			
			var descriptor:IStructureElementDescriptor = nice( IStructureElementDescriptor );
			mock( descriptor ).getter( 'stepCompleted' ).returns( signal );
			
			var structure:IStructure = strict( IStructure );
			mock( structure ).method( 'getElementDescriptor' ).args( 'elementId' ).returns( descriptor );
			
//			when
			step.executeByDescriptor( structure, elementId, event );
			
//			then
			assertThat( descriptor, received().method( 'dispatchEventFromElement' ).once() );
		}
		
		
		[Test(async)]
		public function should_dispatch_signal():void
		{
//			then
			proceedOnSignal( this, step.executionCompleted, 100 );
			
//			when
			step.dispatchComplete( new StepResult( true ) );
		}
		
		
		[BeforeClass(async, timeout=100)]
		public static function setUpBeforeClass():void
		{
			Async.proceedOnEvent(TestStep,
				prepare( 
					ISentence,
					IStructure,
					StepResult,
					IStructureElementDescriptor
				),
				Event.COMPLETE);
		}
		
		[AfterClass]
		public static function tearDownAfterClass():void
		{
		}
		
		
	}
}