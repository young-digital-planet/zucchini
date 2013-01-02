package pl.ydp.automation.configuration.context
{
	import org.osflash.signals.Signal;
	import org.robotlegs.core.IContext;
	
	import pl.ydp.automation.AutomationEngine;
	import pl.ydp.automation.configuration.parameters.IAutomationParameters;
	import pl.ydp.automation.configuration.settings.SettingsGateway;
	import pl.ydp.automation.execution.structure.IStructure;
	
	
	public interface IAutomationAppContext extends IContext
	{
		/**
		 * Przekazuje parametry, które są rejestrowane w kontekście aplikacji.
		 */
		function set parameters( parameters:IAutomationParameters ):void;
		function get engine():AutomationEngine;
		/**
		 * Przekazuje ustawienia do poszczególnych modeli (może być wykonywane wielokretnie).
		 */
		function set settingsGateway( settingsGateway:SettingsGateway ):void;
		function get contextCreated():Signal;
		/**
		 * Zwraca strukturę (viewer testowanej aplikacji) przekazanej w parametrach.
		 */
		function get structure():IStructure;
		/**
		 * Konfiguracja injectora kontekstu aplikacji.
		 */
		function startup():void;
	}
}