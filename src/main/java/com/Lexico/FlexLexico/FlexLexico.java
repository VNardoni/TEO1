package com.Lexico.FlexLexico;

import java_cup.runtime.Symbol;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;

public class FlexLexico {

	public ArrayList<String> analizar() throws IOException {
	ArrayList<String> tokenList = new ArrayList<String>();
		try {
			FileReader f = new FileReader("prueba.txt");
			Lexico Lexer = new Lexico(f);
			Symbol token = Lexer.next_token();
			while (token.sym != 0) {
				tokenList.add((String) token.value);
				token = Lexer.next_token();
			}
		} catch (FileNotFoundException ex) {
			System.out.println("No se encontró el archivo");
		}
        return tokenList;
    }

}
