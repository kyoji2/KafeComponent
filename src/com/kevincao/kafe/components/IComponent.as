/*
 * 
 * Copyright (c) 2010 kevincao.com, All Rights Reserved
 * @author		Kevin Cao
 * @email	 	kevin@kevincao.com
 * 
 */
package com.kevincao.kafe.components
{
	import com.kevincao.kafe.behaviors.IBehavior;

	/**
	 * @author Kevin Cao
	 */
	public interface IComponent
	{
		function get behavior() : IBehavior;

		function get enabled() : Boolean;

		function set enabled(value : Boolean) : void;

		function destroy() : void;
	}
}
