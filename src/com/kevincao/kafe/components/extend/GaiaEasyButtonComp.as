package com.kevincao.kafe.components.extend 
{
	import com.kevincao.kafe.components.ButtonBaseComp;
	import com.kevincao.kafe.extend.GaiaEasyButton;

	import flash.display.MovieClip;
	
	[IconFile("GaiaEasyButton.png")]

	/**
	 * @author Kevin Cao
	 */
	public class GaiaEasyButtonComp extends ButtonBaseComp 
	{

		[Inspectable(defaultValue="", type="String")]

		public function get branch() : String
		{
			return GaiaEasyButton(component).branch;
		}

		public function set branch(value : String) : void
		{
			GaiaEasyButton(component).branch = value;
		}

		public function GaiaEasyButtonComp()
		{
			super(new GaiaEasyButton(MovieClip(parent)));
		}
	}
}
