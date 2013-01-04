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
	import utopia.steps.SelectButtonStep;
	
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
				DragSourcelistItemStep
			];
		}
	}
}