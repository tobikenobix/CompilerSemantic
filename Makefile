###
# This Makefile can be used to make a parser for the Simple language
# (Yylex.class) and to make a program (P4.class) that tests the parser and
# the unparse methods in ast.java.
#
# The default makes both the parser and the test program.
#
# make clean removes all generated files.
#
###
CLASSPATH =  .:../jars/java-cup-11b-runtime.jar
JARFILE = ../jars/java-cup-11b.jar
FLAGS = -g -cp $(CLASSPATH)

P4.class: P4.java parser.class Yylex.class ASTnode.class IO.class
	javac $(FLAGS) P4.java

parser.java: simple.cup
	java -jar $(JARFILE) < simple.cup

parser.class: parser.java ASTnode.class Yylex.class Errors.class
	javac $(FLAGS) parser.java

Yylex.class: simple.jlex.java sym.class Errors.class
	javac $(FLAGS) simple.jlex.java

ASTnode.class: ast.java Sequence.class NoCurrentException.class
	javac $(FLAGS) ast.java


simple.jlex.java: simple.jlex
	@echo "IMPORTANT You must replace the simple.jlex file with your scanner"
	@echo "The provided simple.jlex is incomplete and just has what"
	@echo "Is needed so that the incompled parser compiles"
	jflex simple.jlex # use jflex it is more flexiblej
	mv Yylex.java simple.jlex.java # rename the file produced by jflex


sym.class: sym.java
	javac $(FLAGS) sym.java

sym.java: simple.cup
	java -cp $(CLASSPATH) java_cup.Main < simple.cup

Errors.class: Errors.java
	javac Errors.java

Sequence.class: Sequence.java
	javac $(FLAGS) Sequence.java

NoCurrentException.class: NoCurrentException.java
	javac NoCurrentException.java

IO.class: IO.java
	javac $(FLAGS) IO.java

###
# clean
###
clean:
	rm -f *~ *.class parser.java simple.jlex.java

test:	test.sim P4.class 
	@echo "If you get an error below your Parser does not work yet!"
	@echo "Modify the simple.cup specification to implement the language!"
	java -cp $(CLASSPATH) P4 test.sim test.out

###
# submit
###

submit:
	zip submit.zip *.java test.sim Makefile simple.jlex simple.cup test.sim  

###
# handout
###

handout:
	zip handout.zip test.sim Makefile simple.grammar ast.java Errors.java IO.java NoCurrentException.java P4.java Sequence.java simple.cup simple.grammar




