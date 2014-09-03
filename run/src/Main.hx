import hant.CmdOptions;
import hant.PathTools;
import hant.Process;
import haxe.io.Path;
import neko.Lib;
import neko.winapi.Registry;
import Sys;
import sys.FileSystem;
import sys.io.File;
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
			Lib.println("To install run: haxelib run haxescript --install");
			Lib.println("After this you could use '#!/usr/bin/haxescript' in your scripts (on *nix platforms).");
			Lib.println("On Windows *.hs files will be associated with haxescript.");
			Lib.println("Warning: on Windows you can't use more than 9 script options when run *.hs.");
			Sys.exit(1);
		}
	}
	
	static function install()
	{
		if (Sys.systemName() != "Windows")
		{
			File.saveContent("/usr/bin/haxescript", "#!/bin/sh\nhaxelib run haxescript $@\n");
			Sys.exit(Sys.command("chmod", [ "a+x", "/usr/bin/haxescript" ]));
		}
		else
		{
			var haxelib = "";
			
			if (Sys.getEnv("HAXEPATH") != null)
			{
				haxelib = Path.addTrailingSlash(Sys.getEnv("HAXEPATH")) + "haxelib.exe";
			}
			
			if (haxelib == "" || !FileSystem.exists(haxelib))
			{
				for (path in Sys.getEnv("PATH").split(";"))
				{
					haxelib = Path.addTrailingSlash(path) + "haxelib.exe";
					if (FileSystem.exists(haxelib)) break;
				}
			}
			
			if (haxelib == "" || !FileSystem.exists(haxelib))
			{
				Lib.println("Error: haxelib is not found (set HAXEPATH environment variable or include folder with haxelib.exe in PATH ).");
				Sys.exit(2);
			}
			
			haxelib = haxelib.replace("/", "\\");
			
			Registry.setKeyValueString(Registry.HKEY_CLASSES_ROOT, "", ".hs", "HaxeScript");
			Registry.setKeyValueString(Registry.HKEY_CLASSES_ROOT, "HaxeScript\\shell\\open", "command", "\"" + haxelib + "\" run haxescript \"%1\" \"%2\" \"%3\" \"%4\" \"%5\" \"%6\" \"%7\" \"%8\" \"%9\"");
		}
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
			interp.variables.set("Path", Path);
			interp.variables.set("PathTools", PathTools);
			
			var exitCode = Std.parseInt(interp.execute(program));
			
			Sys.exit(exitCode != null ? exitCode : 0);
		}
	}
}