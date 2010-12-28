package com.kevincao.kafe.extend
{
	import flash.display.MovieClip;

	import com.gaiaframework.api.Gaia;
	import com.kevincao.kafe.behaviors.KafeButton;

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
