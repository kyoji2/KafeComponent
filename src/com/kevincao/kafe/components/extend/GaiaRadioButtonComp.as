package com.kevincao.kafe.components.extend 
{
	import flash.display.MovieClip;

	import com.kevincao.kafe.extend.GaiaRadioButton;
	import com.kevincao.kafe.components.ButtonBaseComp;
	
	[IconFile("GaiaRadioButton.png")]

	/**
	 * @author Kevin Cao
	 */
	public class GaiaRadioButtonComp extends ButtonBaseComp 
	{

		[Inspectable(defaultValue=false)]

		public function get selected() : Boolean 
		{
			return GaiaRadioButton(component).selected;
		}

		public function set selected(value : Boolean) : void 
		{
			GaiaRadioButton(component).selected = value;
		}
		
		[Inspectable(defaultValue="defaultGroupName")]

		public function get groupName() : String 
		{
			return GaiaRadioButton(component).groupName;
		}

		public function set groupName(value : String) : void 
		{
			GaiaRadioButton(component).groupName = value;
		}

		[Inspectable(defaultValue="", type="String")]

		public function get branch() : String
		{
			return GaiaRadioButton(component).branch;
		}

		public function set branch(value : String) : void
		{
			GaiaRadioButton(component).branch = value;
		}

		public function GaiaRadioButtonComp()
		{
			super(new GaiaRadioButton(MovieClip(parent)));
		}
	}
}
