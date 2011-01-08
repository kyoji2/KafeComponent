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

	import flash.events.IEventDispatcher;

	/**
	 * @author Kevin Cao
	 */
	public interface IComponent extends IEventDispatcher
	{
		function get behavior() : IBehavior;

		function destroy() : void;
	}
}
