package net.erifdex.ld27.entities;

import com.haxepunk.Entity;
import com.haxepunk.HXP;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Draw;
import com.haxepunk.graphics.Spritemap;
import com.haxepunk.graphics.Text;
import motion.Actuate;
import motion.easing.Quad;
import net.erifdex.ld27.other.GFX;
import net.erifdex.ld27.other.Words;

class Thought extends Entity {

	public var callback		: Word->Void;
	public var word 		: Word;
	public var text 		: String;
	public var pressed		: Bool;
	public var textGraphic	: Text;
	public var speed		: Float;
	public var alpha 		: Float;
	public var alphaTarget 	: Float;

	public function new(x : Float, y : Float, word : Word, callback : Word->Void) { 
		super(x, y);
		this.callback = callback;
		this.word = word;
		this.text = word.word;
		textGraphic = new Text(text, 0, 0, 0, 0, {font:"font/font_thought.ttf"});
		textGraphic.color = 0x30346d;
		textGraphic.size = 20;
		this.addGraphic(textGraphic);
		this.setHitbox(textGraphic.textWidth + 64, textGraphic.textHeight, 32, 0);
		this.collidable = true;
		this.type = "thought";
		this.speed = 1.5 + Math.random() * 0.8;
		this.alpha = 0.1;
		this.alphaTarget = 1;
	}

	public override function added() : Void {
		tweenAway();
	}

	public function tweenBack() : Void {
		Actuate.tween(this, speed, {y:y-15}, false).ease(Quad.easeInOut).onComplete(tweenAway);
	}

	public function tweenAway() : Void {
		Actuate.tween(this, speed, {y:y+15}, false).ease(Quad.easeInOut).onComplete(tweenBack);
	}

	public override function update() : Void {
		this.alpha += 0.2 * alphaTarget;
		this.alpha = HXP.clamp(alpha, 0, 1);
		this.textGraphic.alpha = alpha;

		if(this.alpha <= 0) {
			world.remove(this);
		}

		super.update();
	}

	public override function render() : Void {
		//Draw.rect(Math.round(x - 33), Math.round(y-1), textGraphic.textWidth + 66, textGraphic.textHeight + 2, 0x140c1c, alpha);
		Draw.rect(Math.round(x - 32), Math.round(y), textGraphic.textWidth + 64, textGraphic.textHeight, 0xd37d2c, alpha - 0.2);
		super.render();
	}

}