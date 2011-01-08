package com.kevincao.kafe.behaviors.display
{
	import flash.display.MovieClip;

	/**
	 * @author Kevin Cao
	 */
	public class HScrollBar extends ScrollBarBase
	{

		public function HScrollBar(skin : MovieClip)
		{
			super(skin, ScrollBarDirection.HORIZONTAL);
		}
	}
}
