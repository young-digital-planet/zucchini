package utopia.steps
{
	import utopia.structure.UtopiaStructureComponent;

	public class GoToNextPage extends GoToPageStep
	{
		public static const NAME:String = 'nextPage';
		public static const PATTERN:RegExp = /I move forward one page/;
		
		public function GoToNextPage(resolvedPattern:RegExp)
		{
			super(resolvedPattern);
		}
		
		
		override public function execute( scriptName:String ):void
		{
			var utopiaStructure:UtopiaStructureComponent = structure as UtopiaStructureComponent;
			_pageIndex = utopiaStructure.test.testController.currentItem.index + 1;
			
			super.execute( scriptName );
		}
		
	}
}