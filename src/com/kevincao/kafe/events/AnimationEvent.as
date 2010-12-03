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
		public static const INTRO_START : String = "intro_start";
		public static const INTRO_COMPLETE : String = "intro_complete";
		public static const OUTRO_START : String = "outro_start";
		public static const OUTRO_COMPLETE : String = "outro_complete";

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
