module pars;
import std.stdio, std.range;
import structer, ast;
import lex, axiom, std.string;
import std.ascii : isDigit;
import std.conv, error, safeargs;
import std.datetime;
import std.regex;
import error;

Node[] parser(Tokens[] tokens){
	Node[] result;
	//writeln(iao);
	if (tokens.length > 0 && tokens[0].type == Token.KeyWord && tokens[1].type == Token.Type && tokens[2].type == Token.Name)
	{
		if (tokens[3].type == Token.Func){
			foreach(lk; iao)
			{
				if (lk.funcname == tokens[3].valu)
				{
					result ~= new DefineKeyWordFunc("gen", tokens[1].valu, tokens[2].valu, new FuncCall(lk.funcname, lk.argumnets));
					iao.popFront();
					break;
				} else continue;
			}
		} else {
			if (tokens[1].valu.startsWith("array<") && tokens[1].valu.endsWith(">"))
			{
				result ~= new DefineArray(tokens[2].valu, tokens[1].valu, Tokenlz(tokens[3].valu));
			} else {
				//writeln(tokens[1].valu, " ", tokens[2].valu, " ", tokens[3].valu);
				result ~= new DefineKeyWord("gen", tokens[1].valu, tokens[2].valu, tokens[3].valu);
			}
		}
	} else if(tokens.length > 0 && tokens[0].type == Token.Func){
		foreach(op; iao)
		{
			if (op.funcname == tokens[0].valu)
			{
				result ~= new FuncCall(op.funcname, op.argumnets);
				//writeln("op:" ,op.argumnets);
				//writeln("[PARSER] iao BEFORE = ", iao.length);
				iao.popFront();
				//writeln("[PARSER] iao after = ", iao.length);
				break;
			}
		}
	} else if (tokens.length > 0 && tokens[0].type == Token.BrNeedFunc)
	{
		if (tokens[0].valu == "delegate"){
			foreach (olk; _bdelegate)
			{
				result ~= new DefineDelegate(olk.boolen, olk.bodyo);
			}
		} else {
		bool resulta;
		//writeln(ifs);
		foreach (bk; ifs)
		{
			foreach(k, l; bk.args)
			{
				string patrik = safe_args_string(map_str, l.valu);
				bk.args[k].valu = patrik.strip();
				continue;
			}
			//writeln("me: ", bk);
			if (bk.pical == tokens[0].valu)
			{
				if (bk.args.length >= 3 && bk.args[0].type == Token.Value && bk.args[1].type == Token.Oprators && bk.args[2].type == Token.Value)
				{
					try {
						int left = to!int(bk.args[0].valu);
						int right = to!int(bk.args[2].valu);
						if (bk.args[1].valu == "==")
						{
							if (left == right) resulta = true;
							else resulta = false;
						} else if (bk.args[1].valu == ">")
						{
							if (left > right) resulta = true;
							else resulta = false;
						} else if (bk.args[1].valu == "<")
						{
							if (left < right) resulta = true;
							else resulta = false;
						}
					} catch(Exception e){
						string left = bk.args[0].valu.replace("\"", "");
						string right = bk.args[2].valu.replace("\"", "");
						//writeln("L: " ~ left);
						//writeln("R:" ~ right);
						if (bk.args[1].valu == "==")
						{
							if (left == right) resulta = true;
							else resulta = false;
						} else if (bk.args[1].valu == ">"){
							if (left.length > right.length) resulta = true;
							else resulta = false;
						} else if (bk.args[1].valu == "<")
						{
							if (left.length < right.length) resulta = true;
							else resulta = false;
						} else if(bk.args[1].valu == "="){
							if (left.length == right.length) resulta = true;
							else resulta = false;
						} else {
							_error("Can't use `" ~ bk.args[1].valu ~ "` for this types. (string)");
						}
					}
				} else if (bk.args.length > 1 && bk.args[0].type == Token.Func && bk.args[0].valu == "_while"){
					if (bk.args[1].type == Token.Func){
						Tokens[] ap = lexer(bk.args[1].valu ~ " " ~ bk.args[2].valu);
						result ~= new WhileWithFuncDefine(bk.args[1].valu, ap, bk.bod);
						continue;
					} else if (bk.args[1].valu == "true"){
						result ~= new WhileDefine(true, bk.bod);
						continue;
					}
				}
				//writeln(resulta);
				if (resulta)
				{
					    //writeln("[PARSER] added IfState, body nodes = ", bk.bod.length);
					result ~= new IfState(bk.bod);
					//writeln(bk.bod);
				}
			}
		}
		}
	} else if (tokens.length == 2 && tokens[0].type == Token.Name && tokens[1].type == Token.Value){
		/*
		if (tokens[1].valu.startsWith("! "))
		{
			auto po = regex(`\! (\S+)`);
			auto pl = match(tokens[1].valu, po);
			string type;
			if(!pl.empty) type = pl.captures[1];
			else _error("Need to know type of value.");
			Tokens[] lak = lexer(tokens[1].valu[1 .. tokens[1].valu.length]);
			foreach(i, k; lak)
			{
				if (k.type == Token.MathOprator){
					if (lak[i--].type == Token.Name && lak[i++].type == Token.Name)
					{
						result ~= new MathDefine([new GetValueFromHash(lak[i--].valu)], k.valu, [new GetValueFromHash(lak[i++].valu)]);
					} else {
						try {
							if (type == "int")
							{
								auto i = to!int(lak[i--].valu);
								auto b = to!int(lak[i++].valu);
								result ~= new MathDefine([new NumberDefine(i)], lak.valu, [new NumberDefine(b)]);
							}
						} catch(Exception e)
						{
							_error("Value type not match with whats typed as value type. `" ~ type ~"`.");
						}
					}
				}
			}
		} else */
		result ~= new ChangeValueDefine(tokens[0].valu, tokens[1].valu);
	}
	
	map_str["@RED"] = "\033[31m";
	map_str["@RESET"] = "\033[0m";
	map_str["@BOLD"] = "\033[1m";
	map_str["@GREEN"] = "\033[32m";
	auto clt = Clock.currTime();
	map_str["@DATE"] = to!string(clt.year()) ~ "-" ~ to!string(clt.month()) ~ "-" ~ to!string(clt.day());
	//writeln(ifs);
	//writeln(result);
	return result;

}
