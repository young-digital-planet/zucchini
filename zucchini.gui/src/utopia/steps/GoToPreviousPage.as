package utopia.steps
{
	import utopia.structure.UtopiaStructureComponent;

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
			var utopiaStructure:UtopiaStructureComponent = structure as UtopiaStructureComponent;
			_pageIndex = utopiaStructure.test.testController.currentItem.index - 1;
			
			super.execute( scriptName );
		}
		
	}
}