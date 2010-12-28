package com.kevincao.kafeui.events
{
	import flash.events.Event;

	/**
	 * @author Kevin Cao
	 */
	public class KUIEvent extends Event
	{
		public static const DRAW : String = "draw";
		public static const RESIZE : String = "resize";
		public static const CHANGE : String = "change";
		public static const CREATE : String = "create";

		public function KUIEvent(type : String, bubbles : Boolean = false, cancelable : Boolean = false)
		{
			super(type, bubbles, cancelable);
		}

		public override function clone() : Event
		{
			return new KUIEvent(type, bubbles, cancelable);
		}

		public override function toString() : String
		{
			return formatToString("KafeEvent", "type", "bubbles", "cancelable");
		}
	}
}
