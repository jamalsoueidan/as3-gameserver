package org.soueidan.game.requests
{
	import org.soueidan.net.Game;
	
	public class JoinRequest extends Request implements IRequests
	{
		
		public function set name(value:String):void {
			_object["object"]["name"] = value;
		}
		
		public function JoinRequest() 
		{
			_object["object"]["request"] = "joinRequest";
			_object["to"] = _game.current;
		}
		
		public function toObject():Object {
			return _object;
		}

	}
}