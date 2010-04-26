package com.kevincao.kafe.events 
{
	import flash.events.Event;

	/**
	 * @author Kevin Cao
	 */
	public class KafeEvent extends Event 
	{
		public static const BUTTON_DOWN : String = "buttonDown";
		public static const DRAW : String = "draw";
		public static const RESIZE : String = "resize";

		public function KafeEvent(type : String, bubbles : Boolean = false, cancelable : Boolean = false)
		{
			super(type, bubbles, cancelable);
		}

		public override function clone() : Event 
		{
			return new KafeEvent(type, bubbles, cancelable);
		}

		public override function toString() : String 
		{
			return formatToString("KafeEvent", "type", "bubbles", "cancelable");
		}
	}
}
