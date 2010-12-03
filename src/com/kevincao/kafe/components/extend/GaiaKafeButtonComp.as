package com.kevincao.kafe.components.extend
{
	import com.kevincao.kafe.extend.IGaiaButton;
	import com.kevincao.kafe.behaviors.IKafeButton;
	import com.kevincao.kafe.components.ButtonBaseComp;
	import com.kevincao.kafe.extend.GaiaKafeButton;

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
			return IKafeButton(behavior).toggle;
		}

		public function set toggle(value : Boolean) : void
		{
			IKafeButton(behavior).toggle = value;
		}

		[Inspectable(defaultValue=false)]

		public function get selected() : Boolean
		{
			return IKafeButton(behavior).selected;
		}

		public function set selected(value : Boolean) : void
		{
			IKafeButton(behavior).selected = value;
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
