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
