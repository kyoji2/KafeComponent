/*
 * 
 * Copyright (c) 2010 kevincao.com, All Rights Reserved
 * @author		Kevin Cao
 * @email	 	kevin@kevincao.com
 * 
 */
package com.kevincao.kafe.utils
{
	import flash.display.MovieClip;

	/**
	 * @author Kevin Cao
	 */
	public function getFrame(target : MovieClip, label : String) : int
	{
		var labels : Array = target.currentLabels;
		var l : int = labels.length;

		while(l--)
			if(labels[l].name == label)
				return labels[l].frame;

		return -1;
	}
}
