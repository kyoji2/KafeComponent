package com.kevincao.kafe.components.extend 
{
	import com.kevincao.kafe.components.ButtonBaseComp;
	import com.kevincao.kafe.extend.GaiaButton;

	import flash.display.MovieClip;

	[IconFile("../../../../../../footage/GaiaButton.png")]

	/**
	 * @author Kevin Cao
	 */
	public class GaiaButtonComp extends ButtonBaseComp 
	{

		[Inspectable(defaultValue=false)]

		public function get toggle() : Boolean
		{
			return GaiaButton(component).toggle;
		}

		public function set toggle(value : Boolean) : void
		{
			GaiaButton(component).toggle = value;
		}

		[Inspectable(defaultValue=false)]

		public function get selected() : Boolean 
		{
			return GaiaButton(component).selected;
		}

		public function set selected(value : Boolean) : void 
		{
			GaiaButton(component).selected = value;
		}

		[Inspectable(defaultValue="", type="String")]

		public function get branch() : String
		{
			return GaiaButton(component).branch;
		}

		public function set branch(value : String) : void
		{
			GaiaButton(component).branch = value;
		}

		public function GaiaButtonComp()
		{
			super(new GaiaButton(MovieClip(parent)));
		}
	}
}
