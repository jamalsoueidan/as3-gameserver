package org.soueidan.game.requests
{
	import org.soueidan.game.net.*;
	
	public class Request
	{
		protected var _object:Object;
		protected var _game:Game;
		
		public function Request()
		{
			_game = Game.getInstance();
			 
			_object = new Object();
			_object["object"] = new Object();
		}

	}
}