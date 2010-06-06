package com.kevincao.kafe.components 
{
	import com.kevincao.kafe.AniButton;
	import com.kevincao.kafe.components.ButtonBaseComp;

	import flash.display.MovieClip;
	
	[IconFile("AniButton.png")]

	/**
	 * @author Kevin Cao
	 */
	public class AniButtonComp extends ButtonBaseComp 
	{

		public function AniButtonComp()
		{
			super(new AniButton(MovieClip(parent)));
		}
	}
}
