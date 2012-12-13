package pl.ydp.automation
{
	import flash.events.Event;
	import flash.filesystem.File;
	
	import mockolate.mock;
	import mockolate.nice;
	import mockolate.prepare;
	import mockolate.strict;
	
	import org.flexunit.async.Async;
	import org.osflash.signals.utils.SignalAsyncEvent;
	import org.osflash.signals.utils.handleSignal;
	import org.osflash.signals.utils.proceedOnSignal;
	
	import pl.ydp.automation.configuration.impl.context.DefaultAutomationAppContext;
	import pl.ydp.automation.configuration.impl.scripts.fs.FilesystemScripts;
	import pl.ydp.automation.configuration.impl.scripts.parser.GherkinConfig;
	import pl.ydp.automation.configuration.impl.scripts.steps.DefaultNamespaceVariables;
	import pl.ydp.automation.configuration.impl.scripts.steps.DefaultStepsClasses;
	import pl.ydp.automation.configuration.parameters.IAutomationParameters;
	import pl.ydp.automation.execution.structure.impl.utopia.UtopiaStructureComponent;
	import pl.ydp.automation.scripts.IScriptSource;
	import pl.ydp.automation.scripts.IScripts;
	import pl.ydp.automation.scripts.parser.impl.ScriptParser;
	import pl.ydp.automation.scripts.steps.INamespaceVariables;
	import pl.ydp.automation.scripts.steps.IStepsClasses;
	import pl.ydp.automation.scripts.steps.impl.PressButtonStep;
	import pl.ydp.automation.AutomationCaptain;

	public class TestIntegrityAutomation
	{		
		private var captain:AutomationCaptain;
		
		private var scriptContent1:String =  
			
			'Feature: press button feature' +
				'Scenario: check button working' +
					'Given press btn_2 button'
		;
		
		private var scriptContent2:String = 
			
			'Feature: Some terse yet descriptive text of what is desired' +
				'In order to realize a named business value' +
				'As an explicit system actor' +
				'I want to gain some beneficial outcome which furthers the goal' +
				'Scenario: Some determinable business situation' +
					'Given some And precondition' +
					'And some other precondition' +
					'When some action by the actor' +
					'And some other action' +
					'And yet another action' +
					'Then some testable outcome is achieved' +
					'And something else we can check happens too' +
				'Scenario: A different situation' +
					'Given some precondition' +
					'And some other precondition' +
					'When some action by the actor' +
					'And some other action' +
					'And yet another action' +
					'Then some testable outcome is achieved' +
					'And something else we can check happens too'
		;
				
		[Before]
		public function setUp():void
		{
			captain = new AutomationCaptain();
			
			var scriptSource1:IScriptSource = nice( IScriptSource );
			var scriptSource2:IScriptSource = nice( IScriptSource );
			
			mock( scriptSource1 ).getter( 'name' ).returns( 'script1' );
			mock( scriptSource1 ).getter( 'content' ).returns( scriptContent1 );
			mock( scriptSource1 ).method( 'load' ).dispatches( new Event(Event.COMPLETE) );
			
			mock( scriptSource2 ).getter( 'name' ).returns( 'script2' );
			mock( scriptSource2 ).getter( 'content' ).returns( scriptContent2 );
			mock( scriptSource2 ).method( 'load' ).dispatches( new Event(Event.COMPLETE) );
			
			
			var scripts:IScripts = strict( IScripts );
			
			mock( scripts ).method( 'getScriptSource' ).args( 'script1' ).returns( scriptSource1 );
			mock( scripts ).method( 'getScriptSource' ).args( 'script2' ).returns( scriptSource2 );
			mock( scripts ).getter( 'scripts' ).returns( { script1: scriptSource1, script2: scriptSource2 } );
			mock( scripts ).method( 'initialize' ).dispatches( new Event(Event.COMPLETE) );
			
			
			var stepsClasses:IStepsClasses = strict( IStepsClasses );
			
			mock( stepsClasses ).getter( 'classes' ).returns( [PressButtonStep] );
			
			var namespaceVariables:INamespaceVariables = strict( INamespaceVariables );
			
			mock( namespaceVariables ).getter( 'patterns' ).returns( {identifier: /\w+/} );
			mock( namespaceVariables ).getter( 'variablePattern' ).returns( /{(\w+)}/g );
			mock( namespaceVariables ).getter( 'regexpPrefix' ).returns( '(' );
			mock( namespaceVariables ).getter( 'regexpSufix' ).returns( ')' );
			
			
			var parameters:IAutomationParameters = strict( IAutomationParameters );
			
			mock( parameters ).getter( 'parserConfigClass' ).returns( GherkinConfig );
			mock( parameters ).getter( 'namespaceVariables' ).returns( namespaceVariables );
			mock( parameters ).getter( 'steps' ).returns( stepsClasses );
			
			mock( parameters ).getter( 'scripts' ).returns( scripts );
			mock( parameters ).getter( 'reportDestination' ).returns( null );
			mock( parameters ).getter( 'structure' ).returns( new UtopiaStructureComponent() );
			mock( parameters ).getter( 'scriptParser' ).returns( new ScriptParser() );
			
			captain.parameters = parameters;
			
			
		}
		
		[After]
		public function tearDown():void
		{
		}
		
		
		[Test(async)]
		public function should_proceed_automation():void
		{
			handleSignal( this, captain.configuratingCompleted, onConfiguratingCompleted, 3000 );	
			captain.configure();
		}
		
		private function onConfiguratingCompleted( event:SignalAsyncEvent, data:* = null ):void
		{
			handleSignal( this, captain.preparingCompleted, onPreparingCompleted, 2000 );
			captain.prepare();
		}
		
		private function onPreparingCompleted( event:SignalAsyncEvent, data:* = null ):void
		{
//			proceedOnSignal( this, captain.executionCompleted, 1000 );
//			captain.start();
		}
		
		
		
		
		[BeforeClass(async, timeout=100)]
		public static function setUpBeforeClass():void
		{
			Async.proceedOnEvent(TestIntegrityAutomation,
				prepare( 
					IAutomationParameters, 
					IScripts, 
					IScriptSource,
					IStepsClasses,
					INamespaceVariables
				),
				Event.COMPLETE);
		}
		
		[AfterClass]
		public static function tearDownAfterClass():void
		{
		}
		
		
	}
}