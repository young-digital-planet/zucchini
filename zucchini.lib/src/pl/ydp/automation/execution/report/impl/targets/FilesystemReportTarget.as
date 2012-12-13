package pl.ydp.automation.execution.report.impl.targets
{
	import flash.utils.ByteArray;
	import flash.utils.setTimeout;
	
	import org.osflash.signals.Signal;
	import org.robotlegs.core.IInjector;
	
	import pl.ydp.automation.execution.report.IReportTarget;
	import pl.ydp.automation.execution.storage.StorageModel;
	import pl.ydp.utils.FilesystemUtil;
	
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
			var signal:Signal = new Signal();
			
			var path:String = storageModel.getReportsFile().resolvePath( scriptName + '.xml' ).nativePath;
			var bytes:ByteArray = new ByteArray();
			bytes.writeUTFBytes( report );
			
			filesystemUtil.saveFile( path, bytes );
			setTimeout( signal.dispatch, 0 );
			return signal;
		}
	}
}