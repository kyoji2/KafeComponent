package com.kevincao.kafe.components
{
	import com.kevincao.kafe.behaviors.IKafeButton;
	import com.kevincao.kafe.behaviors.KafeButton;

	import flash.display.MovieClip;

	[IconFile("KafeButton.png")]

	/**
	 * @author Kevin Cao
	 */
	public class KafeButtonComp extends ButtonBaseComp
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

		/**
		 * 
		 */
		public function KafeButtonComp()
		{
			super(new KafeButton(MovieClip(parent)));
		}
	}
}
