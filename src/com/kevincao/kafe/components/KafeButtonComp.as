package com.kevincao.kafe.components
{
	import com.kevincao.kafe.behaviors.display.ISelectableButton;
	import com.kevincao.kafe.behaviors.display.KafeButton;
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
		
		[Inspectable(defaultValue=false)]

		public function get mirror() : Boolean
		{
			return KafeButton(behavior).mirror;
		}

		public function set mirror(value : Boolean) : void
		{
			KafeButton(behavior).mirror = value;
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
