package com.Lexico.FlexLexico;

import java.io.StringReader;

public class FlexLexico {

	public static TokenRulesObject analizar(String inputText) throws Exception {
		StringReader stringReader = new StringReader(inputText);
		Lexico Lexer = new Lexico(stringReader);
		parser sintactico = new parser(Lexer);
        return (TokenRulesObject) sintactico.parse().value;
	}

}
