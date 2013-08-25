package net.erifdex.ld27.scenes;

import com.haxepunk.Scene;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Text;
import com.haxepunk.graphics.Spritemap;
import com.haxepunk.graphics.Image;
import com.haxepunk.utils.Draw;
import motion.Actuate;
import motion.easing.Linear;
import net.erifdex.ld27.entities.Button;
import net.erifdex.ld27.entities.Manager;
import net.erifdex.ld27.entities.FadeableText;
import net.erifdex.ld27.other.GFX;

class CutsceneScene extends OverlayScene {

	public var next : Scene;
	public var messages : Array<String>;
	public var text : FadeableText;
	public var button : Button;
	public var currentMessage : Int;
	public var textSpeed : Float;

	public function new(textSpeed : Float, messages : Array<String>, next : Scene) {
		super();
		this.messages = messages;
		this.next = next;
		this.currentMessage = 0;
		this.textSpeed = textSpeed;
	}

	public function updateText(t : String) : Void {
		text.text.size = 50;
		text.text.text = t;
		while(text.text.textWidth > HXP.width - 64) {
			text.text.size--;
		}
		text.text.x = HXP.halfWidth;
		text.text.x -= text.text.textWidth / 2;
		text.text.y = HXP.height * 0.45;
		text.text.y -= text.text.textHeight / 2;
	}

	public override function begin() : Void {
		button = new Button(HXP.width - 200, HXP.height * 0.8, "Skip", buttonPressed);
		add(button);
		text = new FadeableText("", HXP.halfWidth, HXP.height * 0.45, 0, 0, {font:"font/font.ttf", color:0xDFEFD7});
		add(text);
		text.text.size = 50;
		text.opacity = 0;
		super.begin();
		fadeIn();
		fadeTextIn();
	}

	public function fadeTextIn() : Void {
		updateText(messages[currentMessage]);
		Actuate.tween(text, textSpeed, {opacity: 1}, false).ease(Linear.easeNone).onComplete(function() {
			Actuate.timer(textSpeed).onComplete(fadeTextOut);
		});
	}

	public function fadeTextOut() : Void {
		Actuate.tween(text, textSpeed, {opacity: 0}, false).ease(Linear.easeNone).onComplete(function() {
			this.currentMessage++;
			if(this.currentMessage >= messages.length) {
				button.textGraphic.text = "Next";
				button.textGraphic.x = 64;
				button.textGraphic.x -= button.textGraphic.textWidth / 2;
			} else {
				fadeTextIn();
			}
		});
	}

	public function buttonPressed() : Void {
		fadeOut(next);
	}

	public override function update() : Void {
		super.update();
	}

	public override function render() : Void {
		Draw.rect(0, 0, HXP.width, HXP.height, 0x140c1c);
		super.render();
	}

}