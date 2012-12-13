package pl.ydp.automation.configuration.context
{
	import org.osflash.signals.Signal;
	import org.robotlegs.core.IContext;
	
	import pl.ydp.automation.AutomationEngine;
	import pl.ydp.automation.configuration.settings.SettingsGateway;
	import pl.ydp.automation.configuration.parameters.IAutomationParameters;
	import pl.ydp.automation.execution.structure.IStructure;
	
	public interface IAutomationAppContext extends IContext
	{
		function set parameters( parameters:IAutomationParameters ):void;
		function get engine():AutomationEngine;
		function set settingsGateway( settingsGateway:SettingsGateway ):void;
		function get contextCreated():Signal;
		function get structure():IStructure;
		function startup():void;
	}
}