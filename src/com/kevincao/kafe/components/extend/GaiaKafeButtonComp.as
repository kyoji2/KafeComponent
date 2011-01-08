package com.kevincao.kafe.components.extend
{
	import com.kevincao.kafe.behaviors.display.ISelectableButton;
	import com.kevincao.kafe.behaviors.display.extend.GaiaKafeButton;
	import com.kevincao.kafe.behaviors.display.extend.IGaiaButton;
	import com.kevincao.kafe.components.ButtonBaseComp;
	import flash.display.MovieClip;


	[IconFile("GaiaKafeButton.png")]

	/**
	 * @author Kevin Cao
	 */
	public class GaiaKafeButtonComp extends ButtonBaseComp
	{

		[Inspectable(defaultValue=false)]

		public function get toggle() : Boolean
		{
			return ISelectableButton(behavior).toggle;
		}

		public function set toggle(value : Boolean) : void
		{
			ISelectableButton(behavior).toggle = value;
		}

		[Inspectable(defaultValue=false)]

		public function get selected() : Boolean
		{
			return ISelectableButton(behavior).selected;
		}

		public function set selected(value : Boolean) : void
		{
			ISelectableButton(behavior).selected = value;
		}

		[Inspectable(defaultValue="", type="String")]

		public function get branch() : String
		{
			return IGaiaButton(behavior).branch;
		}

		public function set branch(value : String) : void
		{
			IGaiaButton(behavior).branch = value;
		}

		public function GaiaKafeButtonComp()
		{
			super(new GaiaKafeButton(MovieClip(parent)));
		}
	}
}
