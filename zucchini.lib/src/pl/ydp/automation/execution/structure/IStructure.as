package pl.ydp.automation.execution.structure
{
	import flash.display.DisplayObject;
	import flash.display.IBitmapDrawable;

	/**
	 * API dla struktury testowanej aplikacji
	 * (przez Structure rozumiany jest komponent wyświetlający aplikację,
	 * w tym przypadku pełni rolę wrappera, viewera...).
	 */
	public interface IStructure
	{
		/**
		 * Dostarcza desktyptora elementu struktury.
		 * @param ElementId identyfikator elementu
		 * @return Obiekt opisujący element struktury
		 */
		function getElementDescriptor( elementId:String ):IStructureElementDescriptor;
		/**
		 * Daje dostęp do elementu struktury.
		 * @param elementId Identyfikator elementu
		 * @return Element struktury
		 */
		function getElement( elementIdOrFunc:*, elementNumber:int = 0 ):*;
		/**
		 * @return Element wizualny, który ma być źródłem snapshotów.
		 */
		function get snapshotSource():IBitmapDrawable;
		/**
		 * Wyczyszczenie widoku (usunięcie struktury).
		 */
		function clean():void;
		/**
		 * Kontener zawierający widok aplikacji.
		 */
		function get component():DisplayObject;
	}
}