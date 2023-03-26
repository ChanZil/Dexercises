module exercise1;

import std.stdio;    // Standard input/output library
import std.file;     // File and directory manipulation library
import std.path;     // Path manipulation library
import std.algorithm;// Algorithms library
import std.array;    // Array manipulation library
import std.conv;     // Conversion library
import std.string;   // String manipulation library

void arithmetic(char[] cmd, File file){
    switch(cmd){
        case "add":
            file.writefln("@SP\nA=M-1\nD=M\nA=A-1\nM=D+M\n@SP\nM=M-1");
			break;
        case "sub":
            file.writefln("@SP
						  AM=M-1
						  D=M
						  A=A-1
						  M=M-D");
			break;
        case "neg":
            file.writefln("@SP
						  A=M-1
						  M=-M");
			break;
        case "eq":
            file.writefln("@SP
                          A=M-1
						  D=M
						  A=A-1
						  D=D-M
						  @IF_TRUE0
						  D;JEQ
						  D=0
						  @IF_FALSE0
						  0;JMP
						  (IF_TRUE0)
						  D=-1
						  (IF_FALSE0)
						  @SP
						  A=M-1
						  A=A-1
						  M=D
						  @SP
						  M=M-1");
			break;
        case "gt":
            file.writefln("@SP
						  AM=M-1
						  D=M
						  A=A-1
						  D=M-D
						  @GREATER_THAN
						  D;JGT
						  @SP
						  A=M-1
						  M=0
						  @END
						  0;JMP
						  (GREATER_THAN)
						  @SP
						  A=M-1
						  M=-1
						  (END)");
			break;
        case "lt":
            file.writefln("@SP
						  AM=M-1
						  D=M
						  A=A-1
						  D=M-D
						  @LESS_THAN
						  D;JLT
						  @SP
						  A=M-1
						  M=0
						  @END
						  0;JMP
						  (LESS_THAN)
						  @SP
						  A=M-1
						  M=-1
						  (END)");
			break;
        case "and":
            file.writefln("@SP
						  AM=M-1
						  D=M
						  A=A-1
						  M=D&M");
			break;
        case "or":
            file.writefln("@SP
						  AM=M-1
						  D=M
						  A=A-1
						  M=D|M");
			break;
        case "not":
            file.writefln("@SP
						  A=M-1
						  M=!M");
			break;
		default:
			writeln("Error");
	}
	writeln("function1");
}

void popTranslator(char[] segment, int index, File file){
	switch(segment){
		case "argument":
			file.writefln("@ARG
						  D=M
						  @%d
						  D=D+A
						  @R13
						  M=D
						  @SP
						  AM=M-1
						  D=M
						  @R13
						  A=M
						  M=D", index);
			break;
		case "local":
			file.writefln("@LCL
						  D=M
						  @%d
						  D=D+A
						  @R13
						  M=D
						  @SP
						  AM=M-1
						  D=M
						  @R13
						  A=M
						  M=D", index);
			break;
		case "static":
			file.writefln("@SP
						  AM=M-1
						  D=M
						  @static.%d
						  M=D", index);
			break;
		case "this":
			file.writefln("@THIS
						  D=M
						  @%d
						  D=D+A
						  @R13
						  M=D
						  @SP
						  AM=M-1
						  D=M
						  @R13
						  A=M
						  M=D", index);
			break;
		case "that":
			file.writefln("@THAT
						  D=M
						  @%d
						  D=D+A
						  @R13
						  M=D
						  @SP
						  AM=M-1
						  D=M
						  @R13
						  A=M
						  M=D", index);
			break;
		case "pointer":
			file.writefln("@SP
						  AM=M-1
						  D=M
						  @THIS
						  D=A
						  @%d
						  D=D+A
						  @R13
						  M=D
						  @R13
						  A=M
						  M=D", index);
			break;
		case "temp":
			file.writefln("@R5
						  D=A
						  @%d
						  D=D+A
						  @R13
						  M=D
						  @SP
						  AM=M-1
						  D=M
						  @R13
						  A=M
						  M=D", index);
			break;
		default:
			writeln("Error");
	}
	writeln("function2");
}

void pushTranslator(char[] segment, int index, File file){
	switch(segment){
		case "argument":
			file.writefln("@ARG
						  D=M
						  @%d
						  A=D+A
						  D=M
						  @SP
						  A=M
						  M=D
						  @SP
						  M=M+1", index);
			break;
		case "local":
			file.writefln("@LCL
						  D=M
						  @%d
						  A=D+A
						  D=M
						  @SP
						  A=M
						  M=D
						  @SP
						  M=M+1", index);
			break;
		case "static":
			file.writefln("@static.%d
						  D=M
						  @SP
						  A=M
						  M=D
						  @SP
						  M=M+1", index);
			break;
		case "constant":
			file.writefln("@%d
						  D=A
						  @SP
						  A=M
						  M=D
						  @SP
						  M=M+1", index);
			break;
		case "this":
			file.writefln("@THIS
						  D=M
						  @%d
						  A=D+A
						  D=M
						  @SP
						  A=M
						  M=D
						  @SP
						  M=M+1", index);
			break;
		case "that":
			file.writefln("@THAT
						  D=M
						  @%d
						  A=D+A
						  D=M
						  @SP
						  A=M
						  M=D
						  @SP
						  M=M+1", index);
			break;
		case "pointer":
			file.writefln("@THIS
						  D=A
						  @%d
						  A=D+A
						  D=M
						  @SP
						  A=M
						  M=D
						  @SP
						  M=M+1", index);
			break;
		case "temp":
			file.writefln("@R5
						  D=A
						  @%d
						  A=D+A
						  D=M
						  @SP
						  A=M
						  M=D
						  @SP
						  M=M+1", index);
			break;
		default:
			writeln("Error");
	}
	writeln("function1");
}



int main(string[] args)
{
    //writeln("Hello D World!\n");
    
    // Set the input and output paths
    string inputPath = "C:\\exercise1\\StackArithmetic\\SimpleAdd";
    string outputPath = buildPath("", "t.asm");
    // Open the output file for writing
    auto outputFile = File(outputPath, "w");

    // Iterate over all files in the input directory that have the ".vm" extension
    foreach (entry; dirEntries(inputPath, SpanMode.shallow).filter!(a => a.isFile && a.name.extension == ".vm")) {
        // Iterate over each line in the file
        foreach (line; File(buildPath(inputPath, entry.name)).byLine()) {
			auto words = line.split();
			if(words.length == 1)
				arithmetic(words[0], outputFile);
			else{
				if(words[0] == "push"){
					int index = to!int(words[2]);
					pushTranslator(words[1], index, outputFile);
				}
				if(words[0] == "pop"){
					int index = to!int(words[2]);
					popTranslator(words[1], index, outputFile);
				}
			}
		}
    }



    writeln("press enter to continue");
    readln();
    return 0;
}
