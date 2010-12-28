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
	public interface IKafeButton extends IButton
	{
		function get selected() : Boolean;

		function set selected(value : Boolean) : void;

		function get toggle() : Boolean;

		function set toggle(value : Boolean) : void;
	}
}
