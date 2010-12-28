/*
 * 
 * Copyright (c) 2010 kevincao.com, All Rights Reserved
 * @author		Kevin Cao
 * @email	 	kevin@kevincao.com
 * 
 */
package com.kevincao.kafe.behaviors
{
	/**
	 * @author Kevin Cao
	 */
	public interface IButton extends IBehavior
	{
		function get href() : String;

		function set href(value : String) : void;

		function get window() : String;

		function set window(value : String) : void;

		function get autoRepeat() : Boolean;

		function set autoRepeat(value : Boolean) : void;

		function goto() : void;
	}
}
