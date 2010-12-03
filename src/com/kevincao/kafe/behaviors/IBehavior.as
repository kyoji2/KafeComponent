/*
 * 
 * Copyright (c) 2010 kevincao.com, All Rights Reserved
 * @author		Kevin Cao
 * @email	 	kevin@kevincao.com
 * 
 */
package com.kevincao.kafe.behaviors
{
	import flash.display.MovieClip;

	/**
	 * @author Kevin Cao
	 */
	public interface IBehavior
	{
		function get skin() : MovieClip;

		function set skin(skin : MovieClip) : void;
	}
}
