package pl.ydp.automation.execution.report.impl.targets
{
	import flash.utils.ByteArray;
	import flash.utils.setTimeout;
	
	import org.osflash.signals.Signal;
	
	import pl.ydp.automation.execution.report.IReportTarget;
	import pl.ydp.automation.execution.storage.StorageModel;
	import pl.ydp.utils.FilesystemUtil;
	import pl.ydp.utils.functions.getSignalAndDispatch;
	
	/**
	 * Implementacja punktu docelowego raportów dla systemu plików.
	 */
	public class FilesystemReportTarget implements IReportTarget
	{
		[Inject]
		public var filesystemUtil:FilesystemUtil;
		[Inject]
		public var storageModel:StorageModel;
		
		
		public function FilesystemReportTarget()
		{
		}
		
		public function send( scriptName:String, report:String):Signal
		{
			var path:String = storageModel.getReportsFile().resolvePath( scriptName + '.xml' ).nativePath;
			var bytes:ByteArray = new ByteArray();
			bytes.writeUTFBytes( report );
			
			filesystemUtil.saveFile( path, bytes );
			
			return getSignalAndDispatch();
		}
	}
}