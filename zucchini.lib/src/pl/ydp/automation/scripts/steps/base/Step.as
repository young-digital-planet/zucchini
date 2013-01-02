package pl.ydp.automation.scripts.steps.base
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.utils.setTimeout;
	
	import org.osflash.signals.Signal;
	
	import pl.ydp.automation.execution.ExecutionModel;
	import pl.ydp.automation.execution.structure.IStructure;
	import pl.ydp.automation.execution.structure.IStructureElementDescriptor;
	import pl.ydp.automation.scripts.parser.vo.ISentence;
	import pl.ydp.automation.scripts.steps.INamespaceVariables;
	import pl.ydp.automation.scripts.steps.StepResult;
	import pl.ydp.utils.TimeFormatter;

	/**
	 * Klasa bazowa dla implementacji wykonywanych kroków.
	 */
	public class Step
	{
		/**
		 * Źródłowe zdanie.
		 */
		protected var _sentence:ISentence;
		/**
		 * Wynikowy wzorzec (po przetworzeniu).
		 */
		protected var _resolvedPattern:RegExp;
		
		protected var _executionCompleted:Signal = new Signal();
		
		/**
		 * Numer szukanego elementu struktury
		 * (większość kroków polega między innymi na wykonaniu jakiejś akcji
		 * na znalezionym elemencie wizualnym, umożliwiając uprzednio
		 * wyszukanie go po jego numerze - chodzi o kolejność
		 * występowania w danej strukturze - dzięki temu można przygotować test
		 * bez znajomości struktury aplikacji, opierając się jedynie na jej widoku).
		 */
		protected var _elementNumber:int;
		
		[Inject]
		public var executionModel:ExecutionModel;
		
		public function Step( resolvedPattern:RegExp )
		{
			_resolvedPattern = resolvedPattern;
		}
		
		
		public function initialize( sentence:ISentence ):void
		{
			_sentence = sentence;
		}
		
		
		/**
		 * Proste wykonanie kroku - kryteria wykonania i proces weryfikacji poprawności wykonania
		 * jest zaimplementowany w deskryptorze elementu, krok jedynie oczekuje na sygnał
		 * zakończenia wraz z wynikiem od deskryptora.
		 * 
		 * @param structure Implementacja struktury zawierającej testowaną aplikację.
		 * @param elementId Element interfejsu użytkownika, na którym wywoływany jest zdarzenie.
		 * @param event Wywoływane zdarzenie.
		 */
		public function executeByDescriptor( structure:IStructure, elementId:String, event:Event ):void
		{
			var elementDescriptor:IStructureElementDescriptor = structure.getElementDescriptor( elementId );
			if( elementDescriptor == null ){
				
				complete( false, 'Element not found in structure' );
				
			}else{
				elementDescriptor.stepCompleted.addOnce( complete );
				elementDescriptor.dispatchEventFromElement( event );
			}
		}
		
		/*
		public function executeByDispatch( structure:IStructure, elementIdOrFunc:*, event:Event ):void
		{
			var element = structure.getElement( elementIdOrFunc );
			( element as EventDispatcher ).dispatchEvent( event );
			
		}
		*/
		
		
		/**
		 * Zakończenie kroku z określonym opóźnieniem
		 * (niektóre kroki mogą wymagać chwili na doładowanie
		 * mimo, że wszystkie eventy już zostały przechwycone).
		 */
		protected function completeWithDelay( delay:int, result:StepResult ):void
		{
			setTimeout( complete, delay, result );
		}
		
		
		/**
		 * Zakończenie kroku.
		 * WAŻNE !!!
		 * Tej funkcji powinny używać implementacje kroków
		 * do powiadomienia o zakończeniu wykonywania, aby uwzględnić
		 * ewentualny interwał między krokami.
		 */
		protected function complete( correctly:Boolean, message:String = null ):void
		{
			var result:StepResult = createResult( correctly, message )
			
			if( executionModel.executionMode == ExecutionModel.SLOW_EXECUTION ){
				
				setTimeout( dispatchComplete, executionModel.stepsInterval, result );
			}else{
				dispatchComplete( result );
			}
		}
		
		protected function createResult( correctly:Boolean, message:String = null ):StepResult
		{
			var stepResult:StepResult = new StepResult( correctly );
			stepResult.message = message;	
			return stepResult;
		}
		
		internal function dispatchComplete( result:StepResult ):void
		{
			_executionCompleted.dispatch( result );
		}
		

		protected function elementNotFound():void
		{
			complete( false, 'Element not found' );
		}
		
		
		public function get sentence():ISentence
		{
			return _sentence;
		}

		public function set sentence(value:ISentence):void
		{
			_sentence = value;
		}

		public function get name():String
		{
			var stepClass:Class = Object( this ).constructor;
			return stepClass.NAME;
		}
		
		public function get resolvedPattern():RegExp
		{
			return _resolvedPattern;
		}

		// publiczna tylko na potrzeby testów
		public function get executionCompleted():Signal
		{
			return _executionCompleted;
		}

		
		

	}
}