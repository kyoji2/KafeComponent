package com.kevincao.kafe.utils
{
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
			var numChildren : int = mc.numChildren;
			for(var i : int = 0;i < numChildren;i++)
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
				var numChildren : int = mc.numChildren;
				for(var i : int = 0;i < numChildren;i++)
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
