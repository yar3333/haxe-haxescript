package substitutions;


class Sys
{
	/**
		Print any value on the standard output.
	**/
	static function print( v : Dynamic ) : Void std.Sys.print(v);

	/**
		Print any value on the standard output, followed by a newline
	**/
	static function println( v : Dynamic ) : Void std.Sys.println(v);

	/**
		Returns all the arguments that were passed by the commandline.
	**/
	static function args() : Array<String>
	{
		var args = std.Sys.args();
		args.pop();
		return args;
	}

	/**
		Returns the value of the given environment variable.
	**/
	static function getEnv( s : String ) : String return std.Sys.getEnv(s);

	/**
		Set the value of the given environment variable.
	**/
	static function putEnv( s : String, v : String ) : Void std.Sys.putEnv(s, v);

	/**
		Returns the whole environement variables.
	**/
	static function environment() : haxe.ds.StringMap<String> return std.Sys.environment();

	/**
		Suspend the current execution for the given time (in seconds).
	**/
	static function sleep( seconds : Float ) : Void std.Sys.sleep(seconds);

	/**
		Change the current time locale, which will affect [DateTools.format] date formating.
		Returns true if the locale was successfully changed
	**/
	static function setTimeLocale( loc : String ) : Bool return std.Sys.setTimeLocale(loc);

	/**
		Get the current working directory (usually the one in which the program was started)
	**/
	static function getCwd() : String return std.Sys.getCwd();

	/**
		Change the current working directory.
	**/
	static function setCwd( s : String ) : Void std.Sys.setCwd(s);

	/**
		Returns the name of the system you are running on. For instance :
			"Windows", "Linux", "BSD" and "Mac" depending on your desktop OS.
	**/
	static function systemName() : String return std.Sys.systemName();

	/**
		Run the given command with the list of arguments. The command output will be printed on the same output as the current process.
		The current process will block until the command terminates and it will return the command result (0 if there was no error).
		Read the [sys.io.Process] api for a more complete way to start background processes.
	**/
	static function command( cmd : String, ?args : Array<String> ) : Int return std.Sys.command(cmd, args);

	/**
		Exit the current process with the given error code.
	**/
	static function exit( code : Int ) : Void std.Sys.exit(code);

	/**
		Gives the most precise timestamp value (in seconds).
	**/
	static function time() : Float return std.Sys.time();

	/**
		Gives the most precise timestamp value (in seconds) but only account for the actual time spent running on the CPU for the current thread/process.
	**/
	static function cpuTime() : Float return std.Sys.cpuTime();

	/**
		Returns the path to the current executable that we are running.
	**/
	static function executablePath() : String return std.Sys.executablePath();

	/**
		Read a single input character from the standard input (without blocking) and returns it. Setting [echo] to true will also display it on the output.
	**/
	static function getChar( echo : Bool ) : Int return std.Sys.getChar(echo);

	/**
		Returns the process standard input, from which you can read what user enters. Usually it will block until the user send a full input line. See [getChar] for an alternative.
	**/
	static function stdin() : haxe.io.Input return std.Sys.stdin();

	/**
		Returns the process standard output on which you can write.
	**/
	static function stdout() : haxe.io.Output return std.Sys.stdout();

	/**
		Returns the process standard error on which you can write.
	**/
	static function stderr() : haxe.io.Output return std.Sys.stderr();

	
}