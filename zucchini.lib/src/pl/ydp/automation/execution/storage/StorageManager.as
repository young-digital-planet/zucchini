package pl.ydp.automation.execution.storage
{
	import flash.filesystem.File;
	
	import pl.ydp.automation.configuration.EnvironmentModel;
	
	/**
	 * Klasa rozwiązująca ścieżki do poszczególnych zasobów.
	 * 
	 * WAŻNE:
	 * Jest to jedyna klasa, która determinuje architekturę 
	 * testowanej aplikacji. Dobrym rozwiązaniem byłoby
	 * stworzenie bardziej abstrakcyjnego interfejsu (np. IStorage)
	 * i przekazanie jego implementacji	jako parametr aplikacji,
	 * który będzie wtryskiwany w bibliotece.
	 */
	public class StorageManager
	{
		[Inject]
		public var storageModel:StorageModel;
		[Inject]
		public var environmentModel:EnvironmentModel;
		
		public function StorageManager()
		{
			
		}
		
		/**
		 * @return Plik ze wzorcem snapshota dla widoku
		 */
		public function getPatternFile( scriptName:String, lessonName:String, pageIndex:int ):File
		{
			var delim:String = getDelimiter();
			
			var patternFile:File;
			patternFile = storageModel.getSnapshotsFile();

			var patternPath:String = 
				environmentModel.wrapperDirName + 
				delim +	scriptName + 
				delim +	lessonName + '_' + pageIndex + '.png';
			patternFile = patternFile.resolvePath( patternPath );
			
			return patternFile;
		}
		
		/**
		 * @return Plik *.utt lekcji
		 */
		public function getLessonFile( lessonName:String, skinName:String ):File
		{
			var delim:String = getDelimiter();
			
			var lessonDir:File;
			lessonDir = storageModel.getContentFile();
			
			var lessonPath:String = lessonName + delim + skinName;
			lessonDir = lessonDir.resolvePath( lessonPath );
			
			var uttFile:File = getUTTFileFromDir( lessonDir );
			
			return uttFile;
		}
		
		public function getUTTFileFromDir( directory:File ):File
		{
			var uttFile:File;
			
			for each( var file:File in directory.getDirectoryListing() ){
				if( file.extension && file.extension.toLowerCase() == 'utt' ){
					uttFile = file;
					break;
				}
			}
			return uttFile;
		}
		
		
		private function getDelimiter():String
		{
			return environmentModel.filesystemDelimiter;
		}
		
	}
}