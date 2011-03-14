package com.kevincao.kafe.utils
{
	import com.kevincao.kafe.behaviors.IBehavior;
	import com.kevincao.kafe.components.IComponent;

	import flash.display.DisplayObject;
	import flash.display.MovieClip;

	/**
	 * @author Kevin Cao
	 */
	public class KafeHelper
	{
		/**
		 * find kafe component in movieclip
		 * 
		 * @param mc:	movieclip that contain component
		 */
		public static function getComponent(mc : MovieClip) : IComponent
		{
			var n : int = mc.numChildren;
			for(var i : int = 0; i < n; i++)
			{
				var child : DisplayObject = mc.getChildAt(i);
				if(child is IComponent)
				{
					// assume that we have only one component
					return IComponent(child);
				}
			}
			return null;
		}
		
		/**
		 * find kafe component's behavior in movieclip
		 * 
		 * @param mc:	movieclip that contain component
		 */
		public static function getBehavior(mc : MovieClip) : IBehavior
		{
			var comp : IComponent = getComponent(mc);
			return comp ? comp.behavior : null;
		}

		/**
		 * helper to destroy components
		 * 
		 * @param mc :		movieclip that contain component
		 * @param recurse :	递归查找子级下的component	
		 */
		public static function destroyComponent(mc : MovieClip, recurse : Boolean = false) : void
		{
			var comp : IComponent = getComponent(mc);
			if(comp)
			{
				comp.destroy();
			}
			if(recurse)
			{
				var n : int = mc.numChildren;
				for(var i : int = 0; i < n; i++)
				{
					var child : DisplayObject = mc.getChildAt(i);
					if(child is MovieClip)
					{
						destroyComponent(MovieClip(child), true);
					}
				}
			}
		}
	}
}
