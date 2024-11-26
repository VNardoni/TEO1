package com.Lexico.FlexLexico;

import java_cup.runtime.Symbol;
import com.Lexico.FlexLexico.sym;
%%

%cup
%public
%class Lexico
%line
%column
%char
%unicode

DIGITO = [0-9]
LETRA_MINUSCULA = [a-zñ]
LETRA_MAYUSCULA = [A-ZÑ]
LETRA = {LETRA_MINUSCULA}|{LETRA_MAYUSCULA}
ESPACIO = [ \t\n\r\f]+
CONST_STRING_ERROR = "'"([^'\n])"'"
CONST_STRING = \"([^\"\n])*\"
CONST_NUM_REAL = {DIGITO}*"."{DIGITO}+|{DIGITO}+"."{DIGITO}*
CONST_NUM_INT = {DIGITO}+
CONST_BASE_BIN = "0b"(0|1)+
ID_ERROR = _({LETRA}|{DIGITO}|_)*
ID = {LETRA_MINUSCULA}({LETRA}|{DIGITO}|_)*
COMENTARIOS = "//*" ~ "//*" ~ "*//" ~ "*//" | "//*" ~ "*//"

%%

<YYINITIAL> {
    "WHILE"                 { return new Symbol(sym.While, yytext()); }
    "IF"                    { return new Symbol(sym.If, yytext()); }
    "THEN"                  { return new Symbol(sym.Then, yytext()); }
    "ELSE"                  { return new Symbol(sym.Else, yytext()); }
    "ENDIF"                 { return new Symbol(sym.Endif, yytext()); }
    "NOT"                   { return new Symbol(sym.Not, yytext()); }
    "AND"                   { return new Symbol(sym.And, yytext()); }
    "OR"                    { return new Symbol(sym.Or, yytext()); }
    "DECLARE.SECTION"       { return new Symbol(sym.Declare_section, yytext()); }
    "ENDDECLARE.SECTION"    { return new Symbol(sym.Enddeclare_section, yytext()); }
    "PROGRAM.SECTION"       { return new Symbol(sym.Program_section, yytext()); }
    "ENDPROGRAM.SECTION"    { return new Symbol(sym.Endprogram_section, yytext()); }
    "AsigComp"              { return new Symbol(sym.Asign_comp, yytext()); }
    "FLOAT"                 { return new Symbol(sym.Float, yytext()); }
    "INT"                   { return new Symbol(sym.Int, yytext()); }
    "STRING"                { return new Symbol(sym.String, yytext()); }
    "WRITE"                 { return new Symbol(sym.Write, yytext()); }

    "{"                     { return new Symbol(sym.Llave_abierta, yytext()); }
    "}"                     { return new Symbol(sym.Llave_cerrada, yytext()); }
    "("                     { return new Symbol(sym.Parentesis_abierto, yytext()); }
    ")"                     { return new Symbol(sym.Parentesis_cerrado, yytext()); }
    "["                     { return new Symbol(sym.Corchete_abierto, yytext()); }
    "]"                     { return new Symbol(sym.Corchete_cerrado, yytext()); }
    "="                     { return new Symbol(sym.Asignacion, yytext()); }
    "<"                     { return new Symbol(sym.Menor_que, yytext()); }
    ">"                     { return new Symbol(sym.Mayor_que, yytext()); }
    ">="                    { return new Symbol(sym.Mayor_o_igual_que, yytext()); }
    "<="                    { return new Symbol(sym.Menor_o_igual_que, yytext()); }
    "=="                    { return new Symbol(sym.Igual, yytext()); }
    "!="                    { return new Symbol(sym.Diferente, yytext()); }
    ":="                    { return new Symbol(sym.Asign_mult, yytext()); }
    ";"                     { return new Symbol(sym.Punto_y_coma, yytext()); }
    ":"                     { return new Symbol(sym.Dos_puntos, yytext()); }
    ","                     { return new Symbol(sym.Coma, yytext()); }
    "+"                     { return new Symbol(sym.Suma, yytext()); }
    "-"                     { return new Symbol(sym.Resta, yytext()); }
    "*"                     { return new Symbol(sym.Multiplicacion, yytext()); }
    "/"                     { return new Symbol(sym.Division, yytext()); }
    {CONST_STRING} {
        if (yytext().length() - 2 <= 30) { // Verifica el límite de 30 caracteres
            return new Symbol(sym.Cte_s, yytext());
        } else {
            return new Symbol(1003, yytext());
        }
    }
    {CONST_NUM_REAL} {
        // if cast to Float fail, return error
        try {
            Float.parseFloat(yytext());
            return new Symbol(sym.Cte_f, yytext());
        } catch (NumberFormatException e) {
            return new Symbol(1004, yytext());
        }
     }
    {CONST_NUM_INT} {
     // if cast to Integer of 16bits fail, return error
        try {
            int num = Integer.parseInt(yytext());
            if (num >= -32768 && num <= 32767) {
                return new Symbol(sym.Cte_i, yytext());
            } else {
                return new Symbol(1005, yytext());
            }
        } catch (NumberFormatException e) {
            return new Symbol(1005, yytext());
        }
    }
    {CONST_BASE_BIN}        { return new Symbol(sym.Cte_b, yytext()); }
    {ID}                    { return new Symbol(sym.Id, yytext()); }
    {COMENTARIOS}           { }
    {ESPACIO}               { }
    {CONST_STRING_ERROR}    { return new Symbol(1001, yytext()); }
    {ID_ERROR}           	{ return new Symbol(1002, yytext()); }
}
[^]                         { return new Symbol(1000, yytext()); }