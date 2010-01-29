package org.soueidan.game.requests
{
	public class GameObjectRequest extends Request implements IRequests
	{
		public function GameObjectRequest()
		{
		}
		
		public function set object(value:Object):void {
			_object["object"] = value;
		}
		
		public function keyAndValue(key:String, value:String):void {
			if ( _object["object"] == null ) {
				_object["object"] = {};
			}
			
			_object["object"][key] = value;
		}
		
		public function toPlayer(player:Object):void {
			_object["object"]["to_session"] = player.session;
		}
		
		public function toSession(session:Number):void {
			_object["object"]["to_session"] = session;
		}
		
		public function toObject():Object
		{
			_object["object"]["request"] = "gameObjectRequest";
			return _object;
		}
		
	}
}