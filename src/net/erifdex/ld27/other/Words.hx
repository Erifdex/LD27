package net.erifdex.ld27.other;

typedef Word = {
	word : String,
	type : Int,
	rating : Float
}

class Words {

	public var managerWordsJson : { types:Array<Dynamic>, words:Array<Dynamic> };
	public var playerWordsArray : Array<String>;
	public var lastWord : Word;

	public function new(managerWordsFile : String, playerWordsArray : Array<String>) {
		var res : { types:Array<Dynamic>, words:Array<Dynamic> } = haxe.Json.parse(managerWordsFile);
		managerWordsJson = res;
		this.playerWordsArray = playerWordsArray;
		trace(getWordsOfType(0));
	}

	private function getTypeMatches(t : Int) : Array<Int> {
		return managerWordsJson.types[t].matches;
	}

	private function getWordsOfType(t : Int) : Array<Word> {
		var arr = new Array<Word>();

		for(w in managerWordsJson.words) {
			if(Std.int(w.type) == t) {
				var word : Word = { word : w.text, type : Std.int(w.type), rating : Std.parseFloat(w.rating) };
				arr.push(word);
			}
		}

		return arr;
	}

	public function submit(word : Word) : Void {
		lastWord = word;
	}

	public function getNext() : Array<Word> {
		var words : Array<Word> = new Array<Word>();
		var tempWords : Array<Word> = new Array<Word>();

		trace(getTypeMatches(0));

		if(lastWord == null) {
			words = getWordsOfType(0);
		} else {
			for(i in getTypeMatches(lastWord.type)) {
				
			}
			//words.concat(getWordsOfType(chooseType));
		}
		return words;
	}
}