package com.kevincao.kafe.behaviors.extend
{
	import com.gaiaframework.api.Gaia;
	import com.kevincao.kafe.behaviors.EasyButton;

	import flash.display.MovieClip;

	/**
	 * @author Kevin Cao
	 */
	public class GaiaEasyButton extends EasyButton implements IGaiaButton
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

		public function GaiaEasyButton(skin : MovieClip)
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
