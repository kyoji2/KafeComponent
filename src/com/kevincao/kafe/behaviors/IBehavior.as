/*
 * 
 * Copyright (c) 2010 kevincao.com, All Rights Reserved
 * @author		Kevin Cao
 * @email	 	kevin@kevincao.com
 * 
 */
package com.kevincao.kafe.behaviors
{
	import flash.events.IEventDispatcher;

	/**
	 * @author Kevin Cao
	 */
	public interface IBehavior extends IEventDispatcher
	{
		function get target() : Object;

		function destroy() : void;
	}
}
