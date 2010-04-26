package com.kevincao.kafe.components 
{
	import com.kevincao.kafe.ButtonBase;
	import com.kevincao.kafe.core.CompBase;
	/**
	 * @author Kevin Cao
	 */
	public class ButtonBaseComp extends CompBase 
	{

		[Inspectable(type="String", defaultValue="")]

		public function get href() : String 
		{ 
			return ButtonBase(component).href; 
		}

		public function set href( value : String ) : void 
		{ 
			ButtonBase(component).href = value; 
		}

		[Inspectable(type="String", defaultValue="_blank")]

		public function get window() : String 
		{ 
			return ButtonBase(component).window; 
		}

		public function set window( value : String ) : void 
		{ 
			ButtonBase(component).window = value; 
		}
		
		/**
		 * 
		 */
		public function ButtonBaseComp(component : ButtonBase)
		{
			super(component);
		}
	}
}
