package com.kevincao.kafe.components
{
	import com.kevincao.kafe.EasyButton;

	import flash.display.MovieClip;
	
	[IconFile("../../../../../footage/EasyButton.png")]
	
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
