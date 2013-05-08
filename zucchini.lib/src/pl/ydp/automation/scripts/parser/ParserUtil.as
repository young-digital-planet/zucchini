package pl.ydp.automation.scripts.parser
{
	import asx.string.empty;
	
	import mx.collections.ArrayCollection;

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
		
		public static function getArrayFromString( source:String, delim:String ):Array
		{
			var array:ArrayCollection = new ArrayCollection( source.split(delim) );
			for each( var param:String in array ){
				if( empty( param ) ){
					array.removeItemAt( array.getItemIndex( param ) );
				}
			}
			return array.toArray();
		}
		
	}
}