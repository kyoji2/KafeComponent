package com.kevincao.kafe.components.extend
{
	import com.kevincao.kafe.behaviors.IKafeButton;
	import com.kevincao.kafe.components.ButtonBaseComp;
	import com.kevincao.kafe.extend.GaiaRadioButton;
	import com.kevincao.kafe.extend.IGaiaButton;

	import flash.display.MovieClip;

	[IconFile("GaiaRadioButton.png")]

	/**
	 * @author Kevin Cao
	 */
	public class GaiaRadioButtonComp extends ButtonBaseComp
	{

		[Inspectable(defaultValue=false)]

		public function get selected() : Boolean
		{
			return IKafeButton(behavior).selected;
		}

		public function set selected(value : Boolean) : void
		{
			IKafeButton(behavior).selected = value;
		}

		[Inspectable(defaultValue="defaultGroupName")]

		public function get groupName() : String
		{
			return GaiaRadioButton(behavior).groupName;
		}

		public function set groupName(value : String) : void
		{
			GaiaRadioButton(behavior).groupName = value;
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

		public function GaiaRadioButtonComp()
		{
			super(new GaiaRadioButton(MovieClip(parent)));
		}
	}
}
