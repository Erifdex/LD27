package net.erifdex.ld27.scenes;

import openfl.Assets;
import com.haxepunk.Scene;
import com.haxepunk.Entity;
import com.haxepunk.graphics.Text;
import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;
import motion.Actuate;
import motion.easing.Quad;
import net.erifdex.ld27.other.GFX;
import net.erifdex.ld27.other.Words;
import net.erifdex.ld27.entities.Manager;
import net.erifdex.ld27.entities.Thought;

class GameScene extends OverlayScene {

	public var words : Words;
	public var text : Text;
	public var manager : Manager;
	public var players : Entity;

	public function new() {
		super();
	}

	public function updateText(t : String) : Void {
		text.text = t;
		text.x = HXP.halfWidth;
		text.x -= text.textWidth / 2;
		text.y = HXP.height / 4;
		text.y -= text.textHeight / 2;
	}

	public function callback(w : Word) : Void {
		trace(w);
	}

	public function showOptions(words : Array<Word>) : Void {
		for(w in words) {
			add(new Thought(Math.random() * 640, Math.random() * 480, w, callback));
		}
	} 

	public override function begin() : Void {
		words = new Words(Assets.getText("data/words.json"), null);
		text = new Text("", HXP.halfWidth, 100, 0, 0, {font:"font/font.ttf"});
		text.size = 50;
		text.color = 0x140c1c;

		addGraphic(text);
		

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

		manager = new Manager(false);
		manager.x = -250;
		manager.y += 64;
		add(manager);
		Actuate.tween(manager, 3, {x: HXP.halfWidth}, false).ease(Quad.easeInOut);
		Actuate.tween(manager.face, 3, {angle: -370}, false).ease(Quad.easeInOut).onComplete(function() {
			manager.face.angle = -10;
			manager.tweenAway();
		});

		showOptions(words.getNext());

		super.begin();
		fadeIn();
	}

}