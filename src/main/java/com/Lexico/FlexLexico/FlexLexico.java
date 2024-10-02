package com.Lexico.FlexLexico;

import java_cup.runtime.Symbol;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.StringReader;
import java.util.ArrayList;

public class FlexLexico {

	public static ArrayList<TokenObject> analizar(String inputText) throws IOException {
		ArrayList<TokenObject> tokenList = new ArrayList<>();
		StringReader stringReader = new StringReader(inputText);
		Lexico Lexer = new Lexico(stringReader);
		for (Symbol token = Lexer.next_token(); token.sym != 0; token = Lexer.next_token()) {
			tokenList.add(new TokenObject((String) token.value, Lexer.yytext()));
		}
		return tokenList;
	}

}
