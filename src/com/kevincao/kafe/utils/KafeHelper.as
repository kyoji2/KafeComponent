package com.kevincao.kafe.utils 
{
	import com.kevincao.kafe.core.CompBase;

	import flash.display.DisplayObject;
	import flash.display.MovieClip;

	/**
	 * @author Kevin Cao
	 */
	public class KafeHelper 
	{
		/**
		 * helper to destroy component
		 * 
		 * @param mc:	movieclip that contain component
		 */
		public static function destroyComponent(mc : MovieClip) : void 
		{
			var numChildren : int = mc.numChildren;
			for (var i : int = 0;i < numChildren;i++) 
			{
				var child : DisplayObject = mc.getChildAt(i);
				if (child is CompBase) 
				{
					CompBase(child).destroy();
					// assume that we have only one component
					return;
				}
			}
		}
	}
}
