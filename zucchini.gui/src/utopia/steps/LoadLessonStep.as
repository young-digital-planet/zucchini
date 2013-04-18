package utopia.steps
{
	import flash.events.Event;
	
	import pl.ydp.automation.execution.IAutomationStep;
	import pl.ydp.automation.execution.storage.StorageManager;
	import pl.ydp.automation.execution.structure.IStructure;
	import pl.ydp.automation.scripts.steps.StepResult;
	import pl.ydp.automation.scripts.steps.base.Step;
	
	import utopia.structure.UtopiaStructure;
	
	public class LoadLessonStep extends Step implements IAutomationStep
	{
		public static const NAME:String = 'loadLesson';
		public static const PATTERN:RegExp = /I load lesson "{identifier}\/{identifier}" page "{number}"/;
		
		private var _lessonName:String;
		private var _skinName:String;
		
		internal var _pageIndex:int;
		
		[Inject]
		public var structure:IStructure;;
		[Inject]
		public var storageManager:StorageManager;
		
		
		public function LoadLessonStep(resolvedPattern:RegExp)
		{
			super(resolvedPattern);
		}
		
		public function set variables(variables:Array):void
		{
			_lessonName = variables[1];
			_skinName = variables[2]
			_pageIndex = parseInt( variables [3] ) - 1;
		}
		
		public function execute(scriptName:String):void
		{
			var lessonPath:String = storageManager.getLessonFile( _lessonName, _skinName ).nativePath;
			
			( structure as UtopiaStructure ).component.addEventListener( 'contentLoadingCompleted', onLoadingCompleted );
			( structure as UtopiaStructure ).loadLessonPage( _lessonName, lessonPath, _pageIndex );
		}
		
		
		private function onLoadingCompleted( e:Event ):void
		{
			completeWithDelay( 1000, true );
		}
		
		public function dispose():void
		{
		}
	}
}