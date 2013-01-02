package pl.ydp.automation.scripts.steps
{
	/**
	 * API dostarczające konfigurację przetwarzania
	 * wzorców kroków na wynikowe wyrażenia regularne.
	 */
	public interface INamespaceVariables
	{
		/**
		 * Wzorzec zmiennych szukanych wewnątrz wzorca stepu.
		 * Wzorzec stepu nie jest standardowo ostatecznym
		 * wyrażeniem regularnym (choć może być) lecz nieco uproszczoną jego wersją,
		 * która w miejscu interesujących nas zmiennych posiada
		 * ustalone reprezentacje cząstkowych wyrażeń regularnych, które te zmienne
		 * mają określać. Tych reprezentacji dostarcza getter <code>patterns()</code>.
		 */
		function get variablePattern():RegExp;
		function get patterns():Object;
	}
}