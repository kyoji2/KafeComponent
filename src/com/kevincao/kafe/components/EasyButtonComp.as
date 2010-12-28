package com.kevincao.kafe.components
{
	import com.kevincao.kafe.behaviors.EasyButton;

	import flash.display.MovieClip;

	[IconFile("EasyButton.png")]

	/**
	 * @author Kevin Cao
	 */
	public class EasyButtonComp extends ButtonBaseComp
	{

		public function EasyButtonComp()
		{
			super(new EasyButton(MovieClip(parent)));
		}
	}
}
