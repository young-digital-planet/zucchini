package pl.ydp.automation.execution.storage
{
	import flash.filesystem.File;

	/**
	 * Model danych określający nazwy poszczególnych folderów
	 * używanych przez aplikację do przechowywania danych w systemie plików.
	 * Dostarcza również dostęp do podstawowych gałęzi struktury.
	 */
	public class StorageModel
	{
		
		
		private const ROOT_DIR_NAME:String = 'storage';
		private const STRUCTURE_DIR_NAME:String = 'structure';
		private const ASSETS_DIR_NAME:String = 'assets';
		private const CONTENT_DIR_NAME:String = 'content';
		private const SNAPSHOTS_DIR_NAME:String = 'snapshots';
		private const REPORTS_DIR_NAME:String = 'reports';
		
		
		private var _rootDir:File;
		
		
		public function StorageModel()
		{
			_rootDir = File.applicationDirectory.resolvePath( ROOT_DIR_NAME );
		}


		public function get rootDir():File
		{
			return _rootDir;
		}
		
		
		private function getStructureFile():File
		{
			return _rootDir.resolvePath( STRUCTURE_DIR_NAME );
		}
		
		
		public function getContentFile():File
		{
			return getStructureFile().resolvePath( CONTENT_DIR_NAME );
		}
		
		private function getAssetsFile():File
		{
			return getStructureFile().resolvePath( ASSETS_DIR_NAME );
		}
		
		public function getSnapshotsFile():File
		{
			return getAssetsFile().resolvePath( SNAPSHOTS_DIR_NAME );
		}
		
		public function getReportsFile():File
		{
			return getStructureFile().resolvePath( REPORTS_DIR_NAME );
		}

	}
}