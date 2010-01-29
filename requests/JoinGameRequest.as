package org.soueidan.game.requests
{
	public class JoinGameRequest extends Request implements IRequests
	{	
		public function set loginKey(value:String):void {
			_object["object"]["login_key"] = value;	
		}
		
		public function set salt(value:String):void {
			_object["object"]["salt"] = value;
		}
		
		public function JoinGameRequest() {
			_object["object"]["request"] = "joinGameRequest";
			_object["to"] = _game.current;
		}
		
		public function toObject():Object {
			return _object;
		}
		
	}
}