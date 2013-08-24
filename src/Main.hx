import com.haxepunk.Engine;
import com.haxepunk.HXP;
import net.erifdex.ld27.scenes.GameScene;

class Main extends Engine
{

	override public function init()
	{
#if debug
		HXP.console.enable();
#end
		HXP.scene = new GameScene();
	}

	public static function main() { new Main(); }

}