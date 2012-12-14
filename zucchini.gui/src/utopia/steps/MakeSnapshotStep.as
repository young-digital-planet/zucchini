package utopia.steps
{
	
	
	
	import com.adobe.images.PNGEncoder;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.geom.Rectangle;
	import flash.utils.ByteArray;
	
	import mx.graphics.ImageSnapshot;
	import mx.graphics.codec.PNGEncoder;
	
	import org.osflash.signals.Signal;
	
	import pl.ydp.automation.execution.IAutomationStep;
	import pl.ydp.automation.execution.storage.StorageManager;
	import pl.ydp.automation.execution.storage.snapshot.SnapshotsManager;
	import pl.ydp.automation.execution.storage.snapshot.SnapshotsModel;
	import pl.ydp.automation.execution.structure.IStructure;
	import pl.ydp.automation.scripts.steps.StepResult;
	import pl.ydp.automation.scripts.steps.base.Step;
	import pl.ydp.utils.FilesystemUtil;
	
	import utopia.structure.UtopiaStructureComponent;
	
	public class MakeSnapshotStep extends Step implements IAutomationStep
	{
		public static const NAME:String = 'makeSnapshot';
		public static const PATTERN:RegExp = /make snapshot/;
		
		[Inject]
		public var structure:IStructure;
		[Inject]
		public var snapshotsManager:SnapshotsManager;
		[Inject]
		public var snapshotsModel:SnapshotsModel;
		[Inject]
		public var storageManager:StorageManager;
		[Inject]
		public var filesystemUtil:FilesystemUtil;
		
		private var _patternPath:String;
		internal var _currentSnapshot:BitmapData;
		private var snapshotBytes:ByteArray;
		private var patternBD:BitmapData;
		
		
		public function MakeSnapshotStep( resolvedPattern:RegExp )
		{
			super(resolvedPattern);
		}
		
		public function set variables( variables:Array ):void
		{
		}
		
		public function execute( scriptName:String ):void
		{
			var lessonName = ( structure as UtopiaStructureComponent ).lessonName;
			var pageIndex = ( structure as UtopiaStructureComponent ).pageIndex;
			
			_currentSnapshot = ImageSnapshot.captureBitmapData( structure.snapshotSource );
			var snapshotImage = ImageSnapshot.captureImage( structure.snapshotSource, 0, new mx.graphics.codec.PNGEncoder() );
			snapshotBytes = snapshotImage.data;
			_patternPath = storageManager.getPatternFile( scriptName, lessonName, pageIndex ).nativePath;
			
			switch(snapshotsModel.mode)
			{
				case SnapshotsModel.COMPARE_MODE:
				{
					compareWithPattern();
					break;
				}
				case SnapshotsModel.PATTERN_MODE:
				{
					saveAsPattern();
					break;
				}
				default:
				{
					complete( false, 'Unknown snapshot making mode ( available:'
						+SnapshotsModel.PATTERN_MODE
						+' and '
						+SnapshotsModel.COMPARE_MODE
						+' )'
					);
					break;
				}
			}
		}
		
		/**
		 * Porównanie nowego snapshota uprzednio zapisanym wzorcem dla strony/elementu.
		 */
		public function compareWithPattern():void
		{
			var patternLoaded:Signal = filesystemUtil.loadFile( _patternPath );
			if( patternLoaded == null ){
				
				complete( false, 'Snapshot pattern load failed' );
				
			}else{
				
				patternLoaded.addOnce( onFileLoadingCompleted );
			}
		}
		
		public function onFileLoadingCompleted( bitmap = null ):void
		{
			if( bitmap == null ){
				
				complete( false, 'Snapshot pattern load failed' );
				
			}else{

				patternBD = ( bitmap as Bitmap ).bitmapData;
				filesystemUtil.loadBytes( snapshotBytes ).addOnce( onSnapshotComplete );
				
			}
		}
		private function onSnapshotComplete( bitmap ):void
		{
			var snapshotBitmap:Bitmap = bitmap;
			var comparingResult:int = snapshotsManager.compare( snapshotBitmap.bitmapData, patternBD );
			var comparingPassed:Boolean = ( comparingResult == 0 );
			
			var message:String;
			if( !comparingPassed ){
				message = 'Snapshot was changed';
			}
			complete( comparingPassed, message );
		}
		
		
		/**
		 * Zapisanie nowego snapshota jako wzorzec dla danej strony/elementu.
		 */
		public function saveAsPattern():void
		{
			var snapshotBytes:ByteArray = com.adobe.images.PNGEncoder.encode( _currentSnapshot );
			filesystemUtil.saveFile( _patternPath, snapshotBytes );
			
			complete( true );
		}
		
		
		
		public function dispose():void
		{
		}
	}
}