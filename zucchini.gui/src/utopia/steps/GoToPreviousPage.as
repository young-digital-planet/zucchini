package utopia.steps
{
	import utopia.structure.UtopiaStructure;

	public class GoToPreviousPage extends GoToPageStep
	{
		public static const NAME:String = 'previousPage';
		public static const PATTERN:RegExp = /I move backward one page/;
		
		public function GoToPreviousPage(resolvedPattern:RegExp)
		{
			super(resolvedPattern);
		}
		
		
		override public function execute( scriptName:String ):void
		{
			var utopiaStructure:UtopiaStructure = structure as UtopiaStructure;
			_pageIndex = utopiaStructure.test.testController.currentItem.index - 1;
			
			super.execute( scriptName );
		}
		
	}
}