package utopia.parameters
{
	import pl.ydp.automation.configuration.impl.scripts.steps.DefaultStepsClasses;
	
	import utopia.steps.DragSourcelistItemStep;
	import utopia.steps.FillTextInputStep;
	import utopia.steps.GoToNextPage;
	import utopia.steps.GoToPageStep;
	import utopia.steps.GoToPreviousPage;
	import utopia.steps.LoadLessonStep;
	import utopia.steps.MakeSnapshotStep;
	import utopia.steps.PressButtonStep;
	import utopia.steps.SelectButtonStep;
	import utopia.steps.SelectDictionaryKeywordStep;
	import utopia.steps.asserts.AssertFillGapAddidionalDictionaryKeywordDescriptionStep;
	import utopia.steps.asserts.AssertFillGapAddidionalDictionaryKeywordStep;
	import utopia.steps.asserts.AssertFillGapStep;
	
	public class UtopiaStepsClasses extends DefaultStepsClasses
	{
		public function UtopiaStepsClasses()
		{
			_classes = [
				LoadLessonStep,
				GoToPageStep,
				GoToNextPage,
				GoToPreviousPage,
				FillTextInputStep,
				SelectButtonStep,
				MakeSnapshotStep,
				DragSourcelistItemStep,
				AssertFillGapStep,
				PressButtonStep,
				SelectDictionaryKeywordStep,
				AssertFillGapAddidionalDictionaryKeywordStep,
				AssertFillGapAddidionalDictionaryKeywordDescriptionStep
			];
			
			logSteps();
		}
		
		private function logSteps():void
		{
			var stepsOutput:String;
			stepsOutput = '-----STEPS START-----';
			for each( var clazz:Class in _classes ){
				stepsOutput += '\n' + clazz.NAME + '\n' + clazz.PATTERN + '\n';
			}
			stepsOutput += '-----STEPS END-----';
			Debug.log( stepsOutput );
		}
	}
}