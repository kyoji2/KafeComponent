package com.kevincao.kafe.components.extend 
{
	import com.kevincao.kafe.components.ButtonBaseComp;
	import com.kevincao.kafe.extend.GaiaKafeButton;

	import flash.display.MovieClip;

	[IconFile("GaiaButton.png")]

	/**
	 * @author Kevin Cao
	 */
	public class GaiaButtonComp extends ButtonBaseComp 
	{

		[Inspectable(defaultValue=false)]

		public function get toggle() : Boolean
		{
			return GaiaKafeButton(component).toggle;
		}

		public function set toggle(value : Boolean) : void
		{
			GaiaKafeButton(component).toggle = value;
		}

		[Inspectable(defaultValue=false)]

		public function get selected() : Boolean 
		{
			return GaiaKafeButton(component).selected;
		}

		public function set selected(value : Boolean) : void 
		{
			GaiaKafeButton(component).selected = value;
		}

		[Inspectable(defaultValue="", type="String")]

		public function get branch() : String
		{
			return GaiaKafeButton(component).branch;
		}

		public function set branch(value : String) : void
		{
			GaiaKafeButton(component).branch = value;
		}

		public function GaiaButtonComp()
		{
			super(new GaiaKafeButton(MovieClip(parent)));
		}
	}
}
