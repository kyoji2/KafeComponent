package com.kevincao.kafe.behaviors.display.extend
{
	import com.gaiaframework.api.Gaia;
	import com.kevincao.kafe.behaviors.display.KafeButton;
	import flash.display.MovieClip;


	/**
	 * @author Kevin Cao
	 */
	public class GaiaKafeButton extends KafeButton implements IGaiaButton
	{

		private var _branch : String;

		public function get branch() : String
		{
			return _branch;
		}

		public function set branch(value : String) : void
		{
			_branch = value;
		}

		public function GaiaKafeButton(skin : MovieClip)
		{
			super(skin);
		}

		override public function goto() : void
		{
			if(_branch && _branch != "")
			{
				Gaia.api.goto(_branch);
			}
			else
			{
				if(href && href != "")
				{
					Gaia.api.href(href, window);
				}
			}
		}
	}
}
