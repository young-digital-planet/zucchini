package pl.ydp.automation.scripts.parser
{
	/**
	 * Narzędzia wykorzystywane przez parser skryptów.
	 */
	public class ParserUtil
	{
		public function ParserUtil()
		{
		}
		
		/**
		 * Zamienia ciąg spacji bądź tabulatorów na pojedynczą spację.
		 */
		public static function removeExtraSpaces(source:String):String
		{
			var tabsRE:RegExp = /\t+/g;
			var spacesRE:RegExp = /( )( )+/g;
			
			source = source.replace( tabsRE, ' ' );
			source = source.replace( spacesRE, ' ' );
			
			return source;
		}
		
	}
}