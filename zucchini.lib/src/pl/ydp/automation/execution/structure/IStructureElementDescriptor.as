package pl.ydp.automation.execution.structure
{
	import flash.events.Event;
	
	import org.osflash.signals.Signal;
	import org.osflash.signals.events.IEvent;

	/**
	 * API deskryptora elementu struktury.
	 * Mogą istnieć kroki, które mogą być takie same dla różnych struktur wejściowych 
	 * (innych aplikacji, na których wykonywane są testy). W przypadku korzystania
	 * z deskryptorów elementów zamiast bezpośrednio z elementów struktury możemy odizolować
	 * definicję kroku (jego istnienie wraz z wzorcem zdania) od struktury, na której jest wykonywany. 
	 * Wtedy weryfikacja wykonania znajdowałaby sie po stronie deskryptora, który byłby dostarczany
	 * wraz ze strukturą. 
	 * Przykład wzorca wykorzystania -> Step.executeByDescriptor().
	 * W przypadku implementacji dla Utopii nie zostało to wykrzystane, ale póki co nie usuwam, może się przyda.
	 */
	public interface IStructureElementDescriptor
	{
		/**
		 * Returns iterable with children
		 */
		function get children():*;
		
		/**
		 * Get child by its id
		 */
		function getElementById( id:String ):*;
		
		/**
		 * Przekazyje event do wywołania
		 * na opisywanym elemencie struktury.
		 */
		function dispatchEventFromElement( event:Event ):void;
		
		function get stepCompleted():Signal;
	}
}