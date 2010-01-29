package org.soueidan.game.requests
{
	public class MessageRequest extends Request implements IRequests
	{		
		public function set text(value:String):void {
			_object["object"]["text"] = value;
		}
		
		public function MessageRequest() {
			_object["object"]["request"] = "messageRequest";
		}
		
		public function set toAllUsers(value:Boolean):void {
		}

		public function toObject():Object
		{
			return _object;
		}
		
	}
}