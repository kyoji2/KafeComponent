package com.kevincao.kafe.extend 
{
	import com.gaiaframework.api.Gaia;
	import com.kevincao.kafe.behaviors.KafeRadioButton;

	/**
	 * @author Kevin Cao
	 */
	public class GaiaRadioButton extends KafeRadioButton 
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

		public function GaiaRadioButton(skin : Object)
		{
			super(skin);
		}

		override public function goto() : void 
		{
			if(_branch && _branch != "") {
				Gaia.api.goto(_branch);
			} else {
				if(href && href != "") {
					Gaia.api.href(href, window);
				}
			}
		}
	}
}
