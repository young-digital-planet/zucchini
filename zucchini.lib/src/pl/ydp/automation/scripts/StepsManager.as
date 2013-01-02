package pl.ydp.automation.scripts
{
	import pl.ydp.automation.execution.AutomationScenario;
	import pl.ydp.automation.execution.AutomationScript;
	import pl.ydp.automation.execution.IAutomationStep;
	import pl.ydp.automation.scripts.parser.vo.IFeature;
	import pl.ydp.automation.scripts.parser.vo.IScenario;
	import pl.ydp.automation.scripts.parser.vo.ISentence;
	import pl.ydp.automation.scripts.steps.StepFactory;
	import pl.ydp.automation.scripts.steps.StepsResolver;

	/**
	 * Manager odpowiedzialny za analizę syntaktyczną zdań scenariuszy
	 * oraz ich mapowanie na odpowiednie kroki testów behawioralnych.
	 */
	public class StepsManager
	{
		[Inject]
		public var stepsResolver:StepsResolver;
		[Inject] 
		public var stepsFactory:StepFactory;
		
		
		
		public function StepsManager()
		{
			
		}
		
		
		public function automateFeature(feature:IFeature):AutomationScript
		{
			var automationScript:AutomationScript = new AutomationScript();
			automationScript.feature = feature;
			
			for each( var scenario:IScenario in feature.scenarios ){
				var automationScenario:AutomationScenario = automateScenario( scenario );
				if( automationScenario != null ){ // DO USUNIECIA? TO NIGDY NIE BEDZIE NULLEM
					automationScript.addAutomationScenario( automationScenario );
				}
			}
			
			return automationScript;
		}
		
		private function automateScenario( scenario:IScenario ):AutomationScenario
		{
			var automationSenario:AutomationScenario = new AutomationScenario( scenario.description );
			
			for each( var sentence:ISentence in scenario.sentences ){
				var step:IAutomationStep = automateSentence( sentence );
				if( step != null ){
					automationSenario.addStep( step );
				}
			}
			
			return automationSenario;
		}
		
		private function automateSentence(sentence:ISentence):IAutomationStep
		{
			var step:IAutomationStep = stepsFactory.getStep(sentence);
			if( step != null ){
				step.initialize( sentence );
				step.variables = findVariables( step );
			}
			return step;
		}
		
		/**
		 * Wydobywa parametry zawarte w zdaniu na podstawie wyrażenia regularnego kroku.
		 */
		private function findVariables( step:IAutomationStep ):Array
		{
			var stepClass:Class = Object(step).constructor;
			var regExp:RegExp = stepsResolver.getResolved( stepClass.NAME );
			regExp.lastIndex = 0;
			var variables:Array = regExp.exec( step.sentence.source );
			return variables;
		}
		
	}
}