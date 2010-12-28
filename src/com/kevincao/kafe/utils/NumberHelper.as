package com.kevincao.kafe.utils 
{

	/**
	 * @author Kevin Cao
	 */
	public class NumberHelper 
	{
		static public function constrain(value : Number, firstValue : Number, secondValue : Number) : Number 
		{
			return Math.min(Math.max(value, Math.min(firstValue, secondValue)), Math.max(firstValue, secondValue));
		}

		public static function interpolate(amount : Number, minimum : Number, maximum : Number) : Number 
		{
			return minimum + (maximum - minimum) * amount;
		}

		public static function normalize(value : Number, minimum : Number, maximum : Number) : Number 
		{
			return (value - minimum) / (maximum - minimum);
		}

		static public function map(value : Number, fromMin : Number, fromMax : Number, toMin : Number, toMax : Number) : Number 
		{
			return toMin + (toMax - toMin) * (value - fromMin) / (fromMax - fromMin);
		}
	}
}
