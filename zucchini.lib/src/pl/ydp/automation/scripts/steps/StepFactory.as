package pl.ydp.automation.scripts.steps
{
	import pl.ydp.automation.execution.IAutomationStep;
	import pl.ydp.automation.scripts.parser.vo.ISentence;

	public class StepFactory
	{
		[Inject] 
		public var stepsRegistry:StepsRegistry;
		[Inject]
		public var stepsResolver:StepsResolver;
		
		private var _currentResolvedPattern:RegExp;
		
		public function StepFactory()
		{
		}
		
		
		
		public function getStep(sentence:ISentence):IAutomationStep
		{
			var stepClass:Class = findStep(sentence);
			var step:IAutomationStep;
			if( stepClass != null ){
				step = new stepClass( _currentResolvedPattern );
			}
			return step;
		}
		
		
		private function findStep(sentence:ISentence):Class
		{
			var stepClass:Class;
			for each(var sClass:Class in stepsRegistry.steps){
				if( checkPatternFromClass( sClass, sentence) ){
					stepClass = sClass;
					break;
				}
			}
			return stepClass;
		}
		
		
		private function checkPatternFromClass(stepClass:Class, sentence:ISentence):Boolean
		{
			var resolvedRE:RegExp = stepsResolver.getResolved( stepClass.NAME );
			if( resolvedRE != null){
				_currentResolvedPattern = resolvedRE;
			}else{
				_currentResolvedPattern = stepClass.PATTERN;
			}
			
			return checkPattern( _currentResolvedPattern, sentence );
		}
		
		//		public for test
		public function checkPattern(regExp:RegExp, sentence:ISentence):Boolean
		{
			var match:Boolean = regExp.test(sentence.source);
			return match;
		}
		
	}
}