/*
 * 
 * Copyright (c) 2010 kevincao.com, All Rights Reserved
 * @author		Kevin Cao
 * @email	 	kevin@kevincao.com
 * 
 */
package com.kevincao.kafe.events
{
	import flash.events.Event;

	/**
	 * @author Kevin Cao
	 */
	public class AnimationEvent extends Event
	{
		public static const ANIMATION_IN : String = "animationIn";
		public static const ANIMATION_IN_COMPLETE : String = "animationInComplete";
		public static const ANIMATION_OUT : String = "animationOut";
		public static const ANIMATION_OUT_COMPLETE : String = "animationOutComplete";
		public static const OVER : String = "over";
		public static const OVER_COMPLETE : String = "overComplete";
		public static const OUT : String = "out";
		public static const OUT_COMPLETE : String = "outComplete";
		public static const DOWN : String = "down";
		public static const DOWN_COMPLETE : String = "downComplete";

		public function AnimationEvent(type : String)
		{
			super(type, false, false);
		}

		public override function clone() : Event
		{
			return new AnimationEvent(type);
		}

		public override function toString() : String
		{
			return formatToString("AnimationEvent", "type");
		}
	}
}
