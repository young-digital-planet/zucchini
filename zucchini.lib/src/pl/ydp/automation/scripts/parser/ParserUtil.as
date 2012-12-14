package pl.ydp.automation.scripts.parser
{
	

	public class ParserUtil
	{
		public function ParserUtil()
		{
		}
		
		public static function removeExtraSpaces(source:String):String
		{
			var tabsRE = /\t+/g;
			var spacesRE = /( )( )+/g;
			
			source = source.replace( tabsRE, ' ' );
			source = source.replace( spacesRE, ' ' );
			
			return source;
		}
		
	}
}