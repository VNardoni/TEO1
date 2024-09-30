package com.Lexico.FlexLexico;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;


public class FlexLexico {

	public static void analizar() throws IOException {
		 try {
	            FileReader f = new FileReader("prueba.txt");
	            Lexico Lexer = new Lexico(f);
	            Lexer.next_token();
	        } catch (FileNotFoundException ex) {
	            System.out.println("No se encontró el archivo");
	        }
	}

}
