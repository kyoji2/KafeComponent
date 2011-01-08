package com.kevincao.kafe.components.extend
{
	import com.kevincao.kafe.behaviors.display.ISelectableButton;
	import com.kevincao.kafe.behaviors.display.extend.GaiaKafeRadioButton;
	import com.kevincao.kafe.behaviors.display.extend.IGaiaButton;
	import com.kevincao.kafe.components.ButtonBaseComp;
	import flash.display.MovieClip;


	[IconFile("GaiaKafeRadioButton.png")]

	/**
	 * @author Kevin Cao
	 */
	public class GaiaKafeRadioButtonComp extends ButtonBaseComp
	{

		[Inspectable(defaultValue=false)]

		public function get selected() : Boolean
		{
			return ISelectableButton(behavior).selected;
		}

		public function set selected(value : Boolean) : void
		{
			ISelectableButton(behavior).selected = value;
		}

		[Inspectable(defaultValue="defaultGroupName")]

		public function get groupName() : String
		{
			return GaiaKafeRadioButton(behavior).groupName;
		}

		public function set groupName(value : String) : void
		{
			GaiaKafeRadioButton(behavior).groupName = value;
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

		public function GaiaKafeRadioButtonComp()
		{
			super(new GaiaKafeRadioButton(MovieClip(parent)));
		}
	}
}
