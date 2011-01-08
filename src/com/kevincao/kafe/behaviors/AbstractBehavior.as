/*
 * 
 * Copyright (c) 2011 kevincao.com, All Rights Reserved
 * @author		Kevin Cao
 * @email	 	kevin@kevincao.com
 * 
 */
package com.kevincao.kafe.behaviors
{
	import flash.events.EventDispatcher;

	/**
	 * @author Kevin Cao
	 */
	public class AbstractBehavior extends EventDispatcher implements IBehavior
	{
		protected var _target : Object;

		public function get target() : Object
		{
			return _target;
		}

		public function AbstractBehavior(target : Object)
		{
			if(!target)
			{
				throw new Error(this + " :: target can't be null.");
			}
			_target = target;
		}

		public function destroy() : void
		{
			_target = null;
		}
	}
}
