package com.kevincao.kafe.behaviors.display
{
	import flash.display.MovieClip;

	/**
	 * @author Kevin Cao
	 */
	public class VScrollBar extends ScrollBarBase
	{

		public function VScrollBar(skin : MovieClip)
		{
			super(skin, ScrollBarDirection.VERTICAL);
		}
	}
}
