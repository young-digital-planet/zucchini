package pl.ydp.automation.scripts.steps
{
	public interface INamespaceVariables
	{
		function get variablePattern():RegExp;
		function get regexpPrefix():String;
		function get regexpSufix():String;
		function get patterns():Object;
	}
}