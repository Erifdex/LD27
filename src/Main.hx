import com.haxepunk.Engine;
import com.haxepunk.HXP;
import net.erifdex.ld27.scenes.*;
import net.erifdex.ld27.other.GFX;

class Main extends Engine
{

	override public function init()
	{
		GFX.init();
#if debug
		//HXP.console.enable();
#end
		HXP.scene = new MenuScene();
	}

	public static function main() { new Main(); }

}