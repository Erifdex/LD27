package net.erifdex.ld27.other;

typedef Word = {
	word : String,
	type : Int,
}

class Words {

	public var managerWordsJson : { types:Array<Dynamic>, words:Array<Dynamic> };
	public var playerWordsArray : Array<String>;
	public var lastWord : Word;
	public var usedWords : Array<Word>;

	public function new(managerWordsFile : String, playerWordsArray : Array<String>) {
		var res : { types:Array<Dynamic>, words:Array<Dynamic> } = haxe.Json.parse(managerWordsFile);
		managerWordsJson = res;
		this.playerWordsArray = playerWordsArray;
		this.usedWords = new Array<Word>();
	}

	private function getTypeMatches(t : Int) : Array<Int> {
		return managerWordsJson.types[t].matches;
	}

	private function getWordsOfType(t : Int) : Array<Word> {
		var arr = new Array<Word>();

		for(w in managerWordsJson.words) {
			if(Std.int(w.type) == t) {
				var word : Word = { word : w.text, type : Std.int(w.type)};
				if(lastWord != null) {
					if(word.word != lastWord.word) {
						arr.push(word);
					}
				} else {
					arr.push(word);
				}
						
			}
		}

		return arr;
	}

	public function submit(word : Word) : Void {
		usedWords.push(word);
		lastWord = word;
	}

	private function randomSort(x:Word, y:Word):Int {
    	return Math.random() > 0.5 ? 1 : -1;
	}

	public function selectAtRandom(a : Array<Word>, count : Int) : Array<Word> {
		a.sort(randomSort);
		var b = new Array<Word>();
		for(i in 0...Math.round(Math.min(a.length, count))) {
			b.push(a[i]);
		}
		return b;
	}

	public function getNext() : Array<Word> {
		var words : Array<Word> = new Array<Word>();
		var tempWords : Array<Word> = new Array<Word>();

		if(lastWord == null) {
			words = getWordsOfType(0);
		} else {
			for(i in getTypeMatches(lastWord.type)) {
				tempWords = tempWords.concat(getWordsOfType(i));
			}
			words = words.concat(selectAtRandom(tempWords, 5));
		}
		return words;
	}
}