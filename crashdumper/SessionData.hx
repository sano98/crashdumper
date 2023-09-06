package crashdumper;
#if flash
	import flash.display.Stage;
#end
#if (windows || mac || linux)
	import sys.io.Process;
#end
/**
 * A simple data structure that represents a single "session" of using your program from start to finish.
 * Traditionally this means from right at the beginning of your program, as soon as you're done bootstrapping the most basic information.
 * @author larsiusprime
 */
class SessionData
{
	public var id:String;						//a unique identifier for this session
	public var fileName:String;					//the name of your executable
	public var packageName:String;				//the name of your package
	public var version:String;					//the version of your program ("version" in project.xml meta tag)
	public var startTime:Date;					//when this session started
	public var customData:Map<String, String>;
	public var files:Map<String,String>;		// backup of all necessary data files as they were at the session start, indexed by filename
												// ->for games, this could be the user's save + config data
												// ->for apps, this could be the user's preferences or other config data
												
	public function new(id_:String,data:{fileName:String,packageName:String,version:String}) 
	{
		id = id_;
		if (id == null || id == "")
		{
			id = generateID();
		}
		fileName = data.fileName;
		packageName = data.packageName;
		version = data.version;
		files = new Map<String,String>();
		startTime = Date.now();
		customData = new Map<String, String>();
	}
	
	public static function generateID(prefix:String="",suffix:String=""):String {
		var now:String = Date.now().toString();
		while (now.indexOf(" ") != -1) {
			now = StringTools.replace(now, " ", "_");
		}
		while (now.indexOf(":") != -1) {
			now = StringTools.replace(now, ":", ".");
		}
		return prefix + now + suffix;
	}
}
