import hant.CmdOptions;
import hant.Process;
import neko.Lib;
import sys.FileSystem;
import sys.io.File;
import Sys;
import hant.PathTools;
using StringTools;

class Main 
{
	static function main() 
	{
        var args = Sys.args();
		
		if (args.length >= 2)
		{
			var curDir = args.pop();
			var param = args.shift();
			
			if (param == "--install") install();
			else
			{
				Sys.setCwd(curDir);
				runScript(param);
			}
		}
		else
		{
			Lib.println("Using: haxelib run haxescript <script_file> [ <script_options>... ]");
			Lib.println("");
			if (Sys.systemName() != "Windows")
			{
				Lib.println("To install on *nix: haxelib run haxescript --install");
				Lib.println("After install you could use '#!/usr/bin/haxescript' in your scripts.");
			}
			else
			{
				Lib.println("On Windows you can manually copy haxescript.cmd to folder in PATH.");
				Lib.println("After this you could use 'haxescript myscript.hs' to run your script.");
			}
			Sys.exit(1);
		}
	}
	
	static function install()
	{
		File.saveContent("/usr/bin/haxescript", "#!/bin/sh\nhaxelib run haxescript $@\n");
	}
	
	static function runScript(scriptFile:String)
	{
		if (!FileSystem.exists(scriptFile) || FileSystem.isDirectory(scriptFile))
		{
			Lib.println("File '" + scriptFile + "' is not found.");
			Sys.exit(2);
		}
		else
		{
			var parser = new hscript.Parser();
			
			var text = File.getContent(scriptFile);
			
			if (text.startsWith("#")) text = "//" + text;
			
			var program = parser.parseString(text);
			
			var interp = new hscript.Interp();
			
			interp.variables.set("Lib", Lib);
			interp.variables.set("Math", Math);
			interp.variables.set("Sys", substitutions.Sys);
			interp.variables.set("FileSystem", FileSystem);
			interp.variables.set("File", File);
			interp.variables.set("StringTools", StringTools);
			interp.variables.set("Lambda", Lambda);
			interp.variables.set("Process", Process);
			interp.variables.set("CmdOptions", CmdOptions);
			
			var exitCode = Std.parseInt(interp.execute(program));
			
			Sys.exit(exitCode != null ? exitCode : 0);
		}
	}
}