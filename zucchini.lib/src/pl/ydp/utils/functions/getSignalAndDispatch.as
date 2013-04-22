package pl.ydp.utils.functions
{
	import flash.utils.setTimeout;
	
	import org.osflash.signals.Signal;

	public function getSignalAndDispatch():Signal
	{
		var signal:Signal = new Signal();
		setTimeout( signal.dispatch, 0 );
		return signal;
	}
}

