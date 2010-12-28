/*
 * 
 * Copyright (c) 2010 kevincao.com, All Rights Reserved
 * @author		Kevin Cao
 * @email	 	kevin@kevincao.com
 * 
 */
package com.kevincao.kafe.utils
{
	import flash.utils.getQualifiedClassName;

	/**
	 * @author Kevin Cao
	 */
	public function getClassName() : String
	{
		return getQualifiedClassName(this).split("::")[1];
	}
}
