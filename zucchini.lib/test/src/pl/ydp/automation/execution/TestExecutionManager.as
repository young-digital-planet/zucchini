package pl.ydp.automation.execution
{
	import asx.fn.partial;
	
	import flash.events.Event;
	
	import mockolate.mock;
	import mockolate.nice;
	import mockolate.prepare;
	import mockolate.strict;
	import mockolate.verify;
	
	import org.flexunit.async.Async;
	import org.osflash.signals.Signal;
	import org.osflash.signals.utils.proceedOnSignal;
	import org.robotlegs.core.IInjector;
	
	import pl.ydp.automation.execution.AutomationScenario;
	import pl.ydp.automation.execution.AutomationScript;
	import pl.ydp.automation.execution.ExecutionManager;
	import pl.ydp.automation.execution.IAutomationStep;
	import pl.ydp.automation.execution.structure.IStructure;
	import pl.ydp.automation.scripts.ScriptsModel;
	import pl.ydp.automation.scripts.steps.StepResult;

	public class TestExecutionManager
	{		
		private var executionManager:ExecutionManager;
		private var scriptsModel:ScriptsModel;
		private var injector:IInjector;
		private var structure:IStructure;
		private var executionModel:ExecutionModel;
		
		
		[Before]
		public function setUp():void
		{
			scriptsModel = strict( ScriptsModel );
			injector = nice( IInjector );	
			structure = nice( IStructure );
			executionModel = strict( ExecutionModel );
			
			executionManager = new ExecutionManager();
			executionManager.scriptsModel = scriptsModel;
			executionManager.injector = injector;
			executionManager.structure = structure;
			executionManager.executionModel = executionModel;
		}
		
		[After]
		public function tearDown():void
		{
		}
		
		
		[Test(async)]
		public function should_finish_execution_A():void
		{
//			given
			mock( scriptsModel ).getter( 'scriptsToExecute' ).returns( [] );
			
//			then
			proceedOnSignal( this, executionManager.allTestsCompleted, 500 );
			
//			when
			executionManager.start();
		}
		
		
		[Test(async)]
		public function should_finish_execution_B():void
		{
//			given
			var script:AutomationScript = strict( AutomationScript );
			mock( script ).getter( 'automationScenarios' ).returns( [] );
			
			mock( scriptsModel ).getter( 'scriptsToExecute' ).returns( [ script ] );
			
//			then
			proceedOnSignal( this, executionManager.allTestsCompleted, 500 );
			
//			when
			executionManager.start();
		}
		
		[Test(async)]
		public function should_finish_execution_C():void
		{
//			given
			var scenario:AutomationScenario = strict( AutomationScenario );
			mock( scenario ).getter( 'steps' ).returns( [] );
			
			var script:AutomationScript = strict( AutomationScript );
			mock( script ).getter( 'automationScenarios' ).returns( [scenario] );
			
			mock( scriptsModel ).getter( 'scriptsToExecute' ).returns( [ script ] );
			
//			then
			proceedOnSignal( this, executionManager.allTestsCompleted, 500 );
			
//			when
			executionManager.start();
		}
		
		[Test(async)]
		public function should_script_execution_started():void
		{
//			given
			var script:AutomationScript = nice( AutomationScript );
			mock( script ).getter( 'automationScenarios' ).returns( [] );
			mock( scriptsModel ).getter( 'scriptsToExecute' ).returns( [ script ] );
			
			executionManager._currentScriptIndex = -1;
			
//			then
			proceedOnSignal( this, executionManager.scriptStarted, 500 );
			
//			when
			executionManager.nextScript();
		}
		
		
		[Test(async)]
		public function should_script_execution_finished():void
		{
//			given
			mock( scriptsModel ).getter( 'scriptsToExecute' ).returns( [] );
		
			executionManager._currentScriptIndex = 0;
			
//			then
			proceedOnSignal( this, executionManager.scriptFinished, 500 );
			
//			when
			executionManager.nextScript();
		}
		
		
		[Test(async)]
		public function should_scenario_execution_started():void
		{
//			given
			var scenario:AutomationScenario = nice( AutomationScenario );
			mock( scenario ).getter( 'steps' ).returns( [] );
			
			var script:AutomationScript = nice( AutomationScript );
			mock( script ).getter( 'automationScenarios' ).returns( [scenario] );
			
			mock( scriptsModel ).getter( 'scriptsToExecute' ).returns( [ script ] );
			
			executionManager._currentScript = script;
			executionManager._currentScenarioIndex = -1;
			
//			then
			proceedOnSignal( this, executionManager.scenarioStarted, 500 );
			
//			when
			executionManager.nextScenario();
		}
		
		[Test(async)]
		public function should_scenario_execution_finished():void
		{
//			given
			var script:AutomationScript = nice( AutomationScript );
			mock( script ).getter( 'automationScenarios' ).returns( [] );
			
			mock( scriptsModel ).getter( 'scriptsToExecute' ).returns( [ script ] );
			
			executionManager._currentScript = script;
			executionManager._currentScriptIndex = 0;
			
//			then
			proceedOnSignal( this, executionManager.scenarioFinished, 500 );
			
//			when
			executionManager.nextScenario();
		}
		
		[Test(async)]
		public function should_step_execution_started():void
		{
//			given
			var result:StepResult = nice( StepResult );
			var signal:Signal = nice( Signal );
			var step:IAutomationStep = strict( IAutomationStep );
			mock( step ).getter( 'executionCompleted' ).returns( signal );
			mock( step ).method( 'execute' ).once();
			
			var scenario:AutomationScenario = nice( AutomationScenario );
			mock( scenario ).getter( 'steps' ).returns( [ step ] );
			
			var script:AutomationScript = nice( AutomationScript );
			mock( script ).getter( 'name' ).returns( 'scriptName' );
			
			executionManager._currentScript = script;
			executionManager._currentScenario = scenario;
			executionManager._currentStepIndex = -1;
			
//			then
			proceedOnSignal( this, executionManager.stepStarted, 500 );
			
//			when
			executionManager.nextStep();
			
//			then
			verify( step );
		}
		
		[Test(async)]
		public function should_step_execution_finished():void
		{
//			given
			
			mock( executionModel ).getter('stopOnFailure').returns( false );
			
			var result:StepResult = nice( StepResult );
			var signal:Signal = new Signal();
			
			var step:IAutomationStep = strict( IAutomationStep );
			mock( step ).getter( 'executionCompleted' ).returns( signal );
			mock( step ).method( 'execute' ).calls(
				step.executionCompleted.dispatch, [ result ]
			);
			
			var scenario:AutomationScenario = nice( AutomationScenario );
			mock( scenario ).getter( 'steps' ).returns( [ step ] );
			
			var script:AutomationScript = nice( AutomationScript );
			mock( script ).getter( 'automationScenarios' ).returns( [] );
			
			mock( scriptsModel ).getter( 'scriptsToExecute' ).returns( [] );
			
			executionManager._currentScript = script;
			executionManager._currentScenario = scenario;
			executionManager._currentScenarioIndex = -1;
			executionManager._currentStepIndex = -1;
			
//			then
			proceedOnSignal( this, executionManager.stepFinished, 500 );
			
//			when
			executionManager.executeStep( step );
		}
		
		
		[Test(async)]
		public function should_step_execution_finished_and_next_step():void
		{
			//			given
			
			mock( executionModel ).getter('stopOnFailure').returns( false );
			
			var firstResult:StepResult = nice( StepResult );
			mock( firstResult ).getter('correctly').returns( true );
			
			var firstSignal:Signal = new Signal();
			
			var firstStep:IAutomationStep = strict( IAutomationStep );
			mock( firstStep ).getter( 'executionCompleted' ).returns( firstSignal );
			mock( firstStep ).method( 'execute' ).calls(
				firstStep.executionCompleted.dispatch, [ firstResult ]
			);
			
			var secondResult:StepResult = nice( StepResult );
			mock( secondResult ).getter('correctly').returns( false );
			
			var secondSignal:Signal = new Signal();

			var secondStep:IAutomationStep = strict( IAutomationStep );
			mock( secondStep ).getter( 'executionCompleted' ).returns( secondSignal );
			mock( secondStep ).method( 'execute' ).calls(
				secondStep.executionCompleted.dispatch, [ secondResult ]
			);
			
			
			
			var scenario:AutomationScenario = nice( AutomationScenario );
			mock( scenario ).getter( 'steps' ).returns( [ firstStep, secondStep ] );
			
			var script:AutomationScript = nice( AutomationScript );
			mock( script ).getter( 'automationScenarios' ).returns( [] );
			
			mock( scriptsModel ).getter( 'scriptsToExecute' ).returns( [] );
						
			executionManager._currentScript = script;
			executionManager._currentScenario = scenario;
			executionManager._currentScenarioIndex = -1;
			executionManager._currentStepIndex = 0;
			
			//			then
			proceedOnSignal( this, firstSignal, 500 );
			proceedOnSignal( this, secondSignal, 500 );
			
			//			when
			executionManager.executeStep( firstStep );
		}
		
		[Test(async)]
		public function should_step_execution_finished_and_not_next_script():void
		{
			//			given
			
			mock( executionModel ).getter('stopOnFailure').returns( false );
			
			var firstResult:StepResult = nice( StepResult );
			mock( firstResult ).getter('correctly').returns( false );
			
			var firstSignal:Signal = new Signal();
			
			var firstStep:IAutomationStep = strict( IAutomationStep );
			mock( firstStep ).getter( 'executionCompleted' ).returns( firstSignal );
			mock( firstStep ).method( 'execute' ).calls(
				firstStep.executionCompleted.dispatch, [ firstResult ]
			);
			
			var secondResult:StepResult = nice( StepResult );
			mock( secondResult ).getter('correctly').returns( false );
			
			var secondSignal:Signal = nice( Signal );
			mock( secondSignal ).method('dispatch').never();
			
			var secondStep:IAutomationStep = strict( IAutomationStep );
			mock( secondStep ).getter( 'executionCompleted' ).returns( secondSignal );
			mock( secondStep ).method( 'execute' ).calls(
				secondStep.executionCompleted.dispatch, [ secondResult ]
			);
			
			
			
			var scenario:AutomationScenario = nice( AutomationScenario );
			mock( scenario ).getter( 'steps' ).returns( [ firstStep, secondStep ] );
			
			var script:AutomationScript = nice( AutomationScript );
			mock( script ).getter( 'automationScenarios' ).returns( [] );
			
			mock( scriptsModel ).getter( 'scriptsToExecute' ).returns( [] );
			
			executionManager._currentScript = script;
			executionManager._currentScenario = scenario;
			executionManager._currentScenarioIndex = -1;
			executionManager._currentStepIndex = 0;
			
			//			then
			proceedOnSignal( this, firstSignal, 500 );
			proceedOnSignal( this, secondSignal, 500, onSecondSignalTimeout );
			
			//			when
			executionManager.executeStep( firstStep );
			
			verify( secondSignal );
		}
		
		private function onSecondSignalTimeout( arg ):void
		{
			
		}
		
		[Test(async)]
		public function should_step_execution_finished_and_next_scenario():void
		{
			
		}
		
		
		[BeforeClass(async, timeout=100)]
		public static function setUpBeforeClass():void
		{
			Async.proceedOnEvent(TestExecutionManager,
				prepare( 
					ScriptsModel, 
					AutomationScript, 
					AutomationScenario, 
					StepResult,
					IAutomationStep,
					Signal,
					ExecutionManager,
					IInjector,
					IStructure,
					ExecutionModel
				),
				Event.COMPLETE);
		}
		
		[AfterClass]
		public static function tearDownAfterClass():void
		{
		}
		
		
	}
}