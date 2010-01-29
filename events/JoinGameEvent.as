package org.soueidan.game.events
{
	import flash.events.Event;
	
	public class JoinGameEvent extends Event implements IGameEvent
	{
		public static const RESPONSE:String = "joinRoomEventResponse";
		
		private var _data:Object;
		
		public function set data(value:Object):void {
			_data = value;
		}
		
		public function JoinGameEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		public function get isFull():Boolean {
			if ( _data["success"] ) {
				return false;
			} else {
				return true;
			}
		}
		
		public function get maxPlayers():Number {
			return _data["max_players"];
		}
		
		public function get joinedPlayers():Number {
			return _data["joined_players"];
		}
		
		public function get currentPlayer():Object {
			return _data["from"];
		}
		
	}
}