package com.kevincao.kafe.components
{
	import com.kevincao.kafe.KafeButton;

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
			return KafeButton(component).toggle;
		}

		public function set toggle(value : Boolean) : void
		{
			KafeButton(component).toggle = value;
		}
		

		[Inspectable(defaultValue=false)]

		public function get selected() : Boolean 
		{
			return KafeButton(component).selected;
		}

		public function set selected(value : Boolean) : void 
		{
			KafeButton(component).selected = value;
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
