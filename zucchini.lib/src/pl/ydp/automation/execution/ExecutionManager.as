package pl.ydp.automation.execution
{
	import flash.utils.getTimer;
	
	import org.osflash.signals.Signal;
	import org.robotlegs.core.IInjector;
	
	import pl.ydp.automation.execution.structure.IStructure;
	import pl.ydp.automation.scripts.ScriptsModel;
	import pl.ydp.automation.scripts.steps.StepResult;

	/**
	 * Zarządza bezpośrednio procesem wykonywania testów:
	 * kontroluje przebieg, wywołuje kroki, rozgłasza sygnały
	 * z przebiegu działania. Obsługuje kroki asynchronicznie.
	 */
	public class ExecutionManager 
	{
		[Inject]
		public var scriptsModel:ScriptsModel;
		[Inject]
		public var structure:IStructure;
		[Inject]
		public var injector:IInjector;
		[Inject]
		public var executionModel:ExecutionModel;
		
		
		internal var _currentScriptIndex:int;
		internal var _currentScript:AutomationScript;
		
		internal var _currentScenarioIndex:int;
		internal var _currentScenario:AutomationScenario;
		
		internal var _currentStepIndex:int;
		private var _currentStep:IAutomationStep;
		
		
		private var _scriptStarted:Signal = new Signal();
		private var _scenarioStarted:Signal = new Signal();
		private var _stepStarted:Signal = new Signal();
		private var _stepFinished:Signal = new Signal();
		private var _scenarioFinished:Signal = new Signal();
		private var _scriptFinished:Signal = new Signal();
		
		private var _executionStarted:Signal = new Signal();
		private var _allTestsCompleted:Signal = new Signal();
		
		private var _stepStartTime:int;
		
		public function ExecutionManager()
		{
		}
		
		
		public function start():void
		{
			_currentScriptIndex = -1;
			
			nextScript();
		}
		
		/**
		 * Zlecenie wykonania kolejnego skryptu.
		 */
		internal function nextScript():void
		{
			if( _currentScriptIndex > -1 ){
				_scriptFinished.dispatch();
			}
			
			_currentScriptIndex++;
			
			if( isNextScript ){
				
				_currentScript = scriptsModel.scriptsToExecute[ _currentScriptIndex ];
				_scriptStarted.dispatch();
				_currentScenarioIndex = -1;
				nextScenario();
				
			}else{
				_allTestsCompleted.dispatch();
			}
		}
		
		/**
		 * Zlecenie wykonania kolejnego scenariusza skryptu.
		 */
		internal function nextScenario():void
		{
			if( wasScenarioBefore ){
				finishPreviousScenario();
			}
			
			_currentScenarioIndex++;
			
			if( isNextScenarioInCurrentScript ){
				
				_currentScenario = _currentScript.automationScenarios[ _currentScenarioIndex ];
				_scenarioStarted.dispatch();
				_currentStepIndex = -1;
				nextStep();
				
			}else{
				nextScript();
			}
		}
		
		/**
		 * Zlecenie wykonania kolejnego kroku scenariusza.
		 */
		internal function nextStep():void
		{
			_currentStepIndex++;
			
			if( isNextStepInCurrentScenario ){
				_stepStarted.dispatch();
				_currentStep = _currentScenario.steps[ _currentStepIndex ];
				_stepStarted.dispatch();
				executeStep ( _currentStep );
			}else{
				nextScenario();	
			}
		}
		
		/**
		 * Wykonanie kroku.
		 */
		internal function executeStep( step:IAutomationStep ):void
		{
			step.executionCompleted.addOnce( onExecutionCompleted );
			injector.injectInto( step );
			_stepStartTime = getTimer();
			step.execute( _currentScript.name );
		}
		
		
		private function onExecutionCompleted( result:StepResult ):void
		{
			result.time = getStepExecutionTime();
			_stepFinished.dispatch( result );
			
			continueExecution( result.correctly );
		}
		
		private function continueExecution( lastResultCorrectly:Boolean ):void
		{
			if( lastResultCorrectly ){
				doAfterCorrectResult();
			}else{
				doAfterIncorrectResult();
			}
		}
		
		private function doAfterCorrectResult():void
		{
			nextStep();
		}
		
		private function doAfterIncorrectResult():void
		{
			if( executionModel.stopOnFailure ){
				if( wasScenarioBefore ){
					finishPreviousScenario();
				}
				nextScript();
			}else{
				nextScenario();	
			}
		}
		
		private function get wasScenarioBefore():Boolean
		{
			return _currentScenarioIndex > -1;
		}
		
		private function finishPreviousScenario():void
		{
			_scenarioFinished.dispatch();
			structure.clean();
		}
		
		private function getStepExecutionTime():int
		{
			var stepEndTime:int = getTimer();
			var executionTime:int = stepEndTime - _stepStartTime;
			return executionTime;
		}
		
		private function get isNextScript():Boolean
		{
			return scriptsModel.scriptsToExecute.length > _currentScriptIndex;
		}
		
		private function get isNextScenarioInCurrentScript():Boolean
		{
			return _currentScript.automationScenarios.length > _currentScenarioIndex;
		}
		
		private function get isNextStepInCurrentScenario():Boolean
		{
			return _currentScenario.steps.length > _currentStepIndex;
		}
		
		public function get allTestsCompleted():Signal
		{
			return _allTestsCompleted;
		}

		public function get scriptStarted():Signal
		{
			return _scriptStarted;
		}

		public function get scenarioStarted():Signal
		{
			return _scenarioStarted;
		}

		public function get stepFinished():Signal
		{
			return _stepFinished;
		}

		public function get scenarioFinished():Signal
		{
			return _scenarioFinished;
		}

		public function get scriptFinished():Signal
		{
			return _scriptFinished;
		}

		public function get stepStarted():Signal
		{
			return _stepStarted;
		}

		public function get currentScriptIndex():int
		{
			return _currentScriptIndex;
		}

		public function get currentScenarioIndex():int
		{
			return _currentScenarioIndex;
		}

		public function get currentStepIndex():int
		{
			return _currentStepIndex;
		}

		public function get executionStarted():Signal
		{
			return _executionStarted;
		}
	}
}