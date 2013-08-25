package net.erifdex.ld27.scenes;

import openfl.Assets;
import com.haxepunk.Scene;
import com.haxepunk.Entity;
import com.haxepunk.graphics.Text;
import com.haxepunk.graphics.Image;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Draw;
import com.haxepunk.tweens.misc.VarTween;
import com.haxepunk.HXP;
import motion.Actuate;
import motion.easing.Quad;
import net.erifdex.ld27.other.GFX;
import net.erifdex.ld27.other.Words;
import net.erifdex.ld27.other.Sound;
import net.erifdex.ld27.entities.Manager;
import net.erifdex.ld27.entities.Thought;

class GameScene extends OverlayScene {

	public var words : Words;
	public var text : Text;
	public var manager : Manager;
	public var players : Entity;
	public var additions : Int;
	public var seconds : Int;
	public var messageX : Float;
	public var done : Bool;
	public var speech : Image;

	public function new() {
		super();
		additions = -1;
		seconds = 10;
		messageX = HXP.width + 32;
	}

	public function removeThoughts() : Void {
		var a = [];
		this.getType("thought", a);
		for(t in a) {
			cast(t).alphaTarget = -1;
			cast(t).collidable = false;
		}
	}

	public function calculateScore() : Float {
		// Huehuehuehuehuehuehuehue
		return Math.random();
	}

	public function showPlayers() : Void {
		removeThoughts();
		Actuate.tween(manager, 1.5, {x:HXP.width * 0.3}, false).ease(motion.easing.Linear.easeNone);
		Actuate.tween(manager.face, 1.5, {scale: 1.5}, false).ease(motion.easing.Linear.easeNone);
		Actuate.tween(players, 1.5, {y: 0}, false).ease(motion.easing.Linear.easeNone);

		Actuate.timer(3).onComplete(function() {
			Sound.playTada();
			speech.alpha = 1;
			text.alpha = 1;
		});

		Actuate.timer(9.5).onComplete(function() {
			Sound.playDrum();
			fadeSpeed = 0.5;
			var score = calculateScore();
			var messages = ["After hearing the words from their coach,\nyour team steps out onto the field\nto play the cup final...", "Was your speech good enough to win the cup?"];
			if(score > 0.75) {
				fadeOut(new CutsceneScene(2, messages, new Yay()));
			} else {
				fadeOut(new CutsceneScene(2, messages, new Nay()));
			}
			Sound.playBeat();
		});
	}

	public function updateText(t : String) : Void {
		text.size = 50;
		additions++;
		if(additions == 1) {
			text.text = "";
			second();
		}
		if(additions % 6 == 0) {
			t = "\n" + t;
		}
		text.text = text.text + " " + t;
		while(text.textWidth > HXP.width - 64) {
			text.size--;
		}
		while(text.textHeight > HXP.height * 0.4 - 64) {
			text.size--;
		}
		text.x = HXP.halfWidth;
		text.x -= text.textWidth / 2;
		text.y = HXP.height / 4;
		text.y -= text.textHeight / 2;
	}

	public function callback(w : Word) : Void {
		removeThoughts();
		updateText(w.word);
		words.submit(w);
		showOptions(words.getNext());
	}

	public function showOptions(words : Array<Word>) : Void {
		for(w in words) {
			var t = new Thought(0, 0, w, callback);
			add(t);
			do {
				t.x = 10 + Math.random() * (620 - t.textGraphic.textWidth);
				t.y = 240 + Math.random() * (230 - t.textGraphic.textHeight);
			} while(t.collide("thought", t.x, t.y) != null);
		}
	} 

	public override function begin() : Void {
		Sound.stopBeat();
		words = new Words(Assets.getText("data/words.json"), null);
		text = new Text("", HXP.halfWidth, 100, 0, 0, {font:"font/font.ttf"});
		text.size = 50;
		text.color = 0x140c1c;
		text.layer = 1;
		var t = addGraphic(text);
		t.layer = 0;
		text.visible = false;
		updateText("Click on the words to construct a speech");

		players = new Entity(0, 200);
		add(players);
		for(x in 0...6) {
			var p = new Image(GFX.PLAYER);
			p.centerOrigin();
			if(Math.random() > 0.5) {
				p.scaleX = -1;
			}
			p.x = x * HXP.width / 5 + (Math.random() * 10) - 5;
			p.y = HXP.height - 70 + Math.random() * 20;
			players.addGraphic(p);
		}

		speech = new Image(GFX.SPEECH);
		speech.alpha = 0;
		speech.layer = 2;
		addGraphic(speech);

		manager = new Manager(false);
		manager.x = -250;
		manager.y += 64;
		manager.layer = 10;
		players.layer = 9;
		add(manager);
		Actuate.tween(manager, 3, {x: HXP.halfWidth}, false).ease(Quad.easeInOut);
		Actuate.tween(manager.face, 3, {angle: -370}, false).ease(Quad.easeInOut).onComplete(function() {
			manager.face.angle = -10;
			manager.tweenAway();
			text.visible = true;
			showOptions(words.getNext());
		});

		super.begin();
		fadeIn();
	}

	public function second() : Void {
		if(seconds <= 0) {
			if(!done) {
				done = true;
				removeThoughts();
				cast(this.addTween(new VarTween())).tween(text, "alpha", 0, 2);
				Actuate.timer(2).onComplete(showPlayers);
			}
		} else {
			Actuate.timer(1).onComplete(function() {
				seconds--;
				Sound.playBeep();
				second();
			});
		}
	}

	public override function render() : Void {
		if(!done) Draw.text(Std.string(seconds) + "s", 24, HXP.height - 40, {size: 30, font: "font/font.ttf", color: 0x140c1c});
		
		super.render();
		Draw.text("What a great speech!", messageX, HXP.height / 2, {size: 50, font: "font/font.ttf", color: 0x140c1c});
	}

	public override function update() : Void {
		if(Input.mousePressed && !done) {
			var t = collidePoint("thought", mouseX, mouseY);
			if(t != null) {
				callback(cast(t).word);
				Sound.playSelect();
			}
		}

		if(done) {
			messageX-=10;
		}
		super.update();
	}

}