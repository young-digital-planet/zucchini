package pl.ydp.automation.execution
{
	import org.flexunit.assertThat;
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertTrue;
	import org.hamcrest.object.equalTo;
	import org.hamcrest.object.isFalse;
	import org.hamcrest.object.isTrue;

	[RunWith("org.flexunit.runners.Parameterized")]
	public class TestExecutionModel
	{		
		private var executionModel:ExecutionModel;
		
//		format: [setterInterval, expectedInterval]
		public static function intervalParameters():Array {
			return [ [-1,0], [0,0], [1,1] ];
		}
		
//		format: [setterInterval, expectedInterval]
		public static function executionModeParameters():Array {
			return [ 
				[-1, ExecutionModel.NORMAL_EXECUTION], 
				[0, ExecutionModel.NORMAL_EXECUTION], 
				[1, ExecutionModel.SLOW_EXECUTION] 
			];
		}
//		format: [setterFlag, expectedFlag]
		public static function stopOnFailureParameters():Array {
			return [ [true,true], [false,false] ];
		}		
		
		[Before]
		public function setUp():void
		{
			executionModel = new ExecutionModel();
		}
		
		[After]
		public function tearDown():void
		{
		}
		
		
		[Test(dataProvider="intervalParameters")]
		public function should_get_correct_interval( setterInterval:int, expectedInterval:int ):void
		{
//			given
			executionModel.stepsInterval = setterInterval;
			
//			when
			var interval:int = executionModel.stepsInterval;
			
//			then
			assertThat( interval, equalTo( expectedInterval ) );
		}
		
		[Test(dataProvider="executionModeParameters")]
		public function should_get_correct_mode( setterInterval:int, expectedMode:String ):void
		{
			//			given
			executionModel.stepsInterval = setterInterval;
			
			//			when
			var mode:String = executionModel.executionMode;
			
			//			then
			assertThat( mode, equalTo( expectedMode ) );
		}
		
		[Test(dataProvider="stopOnFailureParameters")]
		public function should_get_stopOnFailure_true( setterFlag:Boolean, expectedFlag:Boolean ):void
		{
			executionModel.stopOnFailure = true;
			
			assertThat( executionModel.stopOnFailure, isTrue() );
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