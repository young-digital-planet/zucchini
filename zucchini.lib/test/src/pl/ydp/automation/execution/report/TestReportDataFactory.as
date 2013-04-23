package pl.ydp.automation.execution.report
{
	import flash.events.Event;
	
	import mockolate.mock;
	import mockolate.prepare;
	import mockolate.strict;
	
	import org.flexunit.assertThat;
	import org.flexunit.async.Async;
	import org.hamcrest.object.equalTo;
	import org.hamcrest.object.notNullValue;
	
	import pl.ydp.automation.execution.AutomationScript;
	import pl.ydp.automation.execution.report.ReportData;
	import pl.ydp.automation.execution.report.ReportDataFactory;
	import pl.ydp.automation.scripts.steps.StepResult;

	public class TestReportDataFactory
	{		
		
		private var scriptReportFactory:ReportDataFactory;
		
		private var script:AutomationScript;
		
		private const SCRIPT_NAME:String = 'scriptName';
		
		[Before]
		public function setUp():void
		{
			scriptReportFactory = new ReportDataFactory();
			
			script = strict( AutomationScript );
			
			mock( script ).getter( 'name' ).returns( SCRIPT_NAME );
		}
		
		[After]
		public function tearDown():void
		{
		}
		
		
		
		[Test]
		public function should_create_script_report():void
		{
//			given
			mock( script ).getter( 'automationScenarios' ).returns( [] );
			
//			when
			var scriptReport:ReportData = scriptReportFactory.createScriptReport( script );
			
//			then
			assertThat( scriptReport, notNullValue() );
			assertThat( scriptReport.reportXML.testsuite.@name, equalTo( SCRIPT_NAME ) );
		}
		
		[Test]
		public function should_add_scenario_to_report():void
		{
//			given
			var report:ReportData = new ReportData( new XML( <testsuites><testsuite></testsuite></testsuites> ) );
			report.reportXML.testsuite.@name = SCRIPT_NAME;
			var scenarioName:String = 'scenarioName';
			
//			when
			scriptReportFactory.addScenario( report, scenarioName );
			
//			then
			var testcasesList:XMLList = report.reportXML.testsuite.testcase as XMLList;
			
			assertThat( testcasesList.length(), equalTo( 1 ) );
			assertThat( testcasesList[ 0 ].@name, equalTo( scenarioName ) );
			assertThat( testcasesList[ 0 ].@classname, equalTo( SCRIPT_NAME ) );
		}
		
		
		[Test]
		public function should_add_step_to_report():void
		{
//			given
			var report:ReportData = new ReportData( 
				new XML(<testsuites><testsuite><testcase></testcase></testsuite></testsuites> )
			);
			var scenarioName:String = 'scenarioName';
			var stepName:String = 'stepName';
			
			report.reportXML.testsuite.testcase[0].@name = scenarioName;
			
//			when
			scriptReportFactory.addStep( report, scenarioName, stepName );
			
//			then
			var testcasesList:XMLList = report.reportXML.testsuite.testcase as XMLList;
			var teststepsList:XMLList = testcasesList[0].teststep as XMLList;
			
			assertThat( teststepsList.length(), equalTo( 1 ) );
			assertThat( teststepsList[ 0 ].@name, equalTo( stepName ) );
			assertThat( teststepsList[ 0 ].@classname, equalTo( scenarioName ) );
		}
		
		[Test]
		public function should_add_steps_correct_result_to_report():void
		{
			//			given
			var report:ReportData = new ReportData( 
				new XML( <testsuites><testsuite><testcase><teststep></teststep></testcase></testsuite></testsuites> ) 
			);
			var scenarioIndex:int = 0;
			var stepIndex:int = 0;
			var result:StepResult = strict( StepResult );
			var time:int = 1234;
			mock( result ).getter( 'correctly' ).returns( true );
			mock( result ).getter( 'time' ).returns( time );
			
			//			when
			scriptReportFactory.addStepResult( report, scenarioIndex, stepIndex, result );
			
			//			then
			var teststep:XML = report.reportXML.testsuite.testcase[ scenarioIndex ].teststep[ stepIndex ];
			assertThat( teststep.@status, equalTo( 'passed' ) );
			assertThat( teststep.@time, equalTo( time.toString() ) );
		}
		
		[Test]
		public function should_add_steps_incorrect_result_to_report():void
		{
			//			given
			var report:ReportData = new ReportData( 
				new XML( <testsuites><testsuite><testcase><teststep></teststep></testcase></testsuite></testsuites> ) 
			);
			var scenarioIndex:int = 0;
			var stepIndex:int = 0;
			var failureMessage:String = 'failureMessage';
			var result:StepResult = strict( StepResult );
			var time:int = 1234;
			mock( result ).getter( 'correctly' ).returns( false );
			mock( result ).getter( 'message' ).returns( failureMessage );
			mock( result ).getter( 'time' ).returns( time );
			
			//			when
			scriptReportFactory.addStepResult( report, scenarioIndex, stepIndex, result );
			
			//			then
			var testcase:XML = report.reportXML.testsuite.testcase[ scenarioIndex ];
			var failure:XML = testcase.failure[0];
			assertThat( failure, notNullValue() );
			assertThat( failure.@message, equalTo( failureMessage ) );
			
			var teststep:XML = testcase.teststep[ stepIndex ];
			assertThat( teststep.@status, equalTo( 'failed' ) );
			assertThat( teststep.@time, equalTo( time.toString() ) );
		}
		
		
		[BeforeClass(async, timeout=100)]
		public static function setUpBeforeClass():void
		{
			Async.proceedOnEvent(TestReportDataFactory,
				prepare( AutomationScript, StepResult ),
				Event.COMPLETE);
		}
		
		[AfterClass]
		public static function tearDownAfterClass():void
		{
		}
		
		
	}
}