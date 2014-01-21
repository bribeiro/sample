package net.brunoribeiro.tilt.event
{
	import flash.events.Event;
	import flash.events.EventDispatcher;

	public class TiltEvent extends Event
	{
		public static const BROWSE_FILE		: String = "browsefile"; 
		public function TiltEvent(type : String, bubbles : Boolean = false, cancelable : Boolean = false)
		{
			super(type, bubbles, cancelable);
		}
	
	}
}