package com.Lexico.FlexLexico;
import java_cup.runtime.Symbol;
import java_cup.sym;
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
CONST_STRING = "\"" ~ "\""
CONST_STRING_ERROR = "'" ~ "'"
CONST_NUM_REAL = {DIGITO}*"."{DIGITO}+|{DIGITO}+"."{DIGITO}*
CONST_NUM_INT = {DIGITO}+
CONST_BASE_BIN = "0b"(0|1)+
ID = {LETRA_MINUSCULA}({LETRA}|{DIGITO}|_)*
COMENTARIOS = "//*" ~ "//*" ~ "*//" ~ "*//" | "//*" ~ "*//"
WRITE = "WRITE" ({ID}|{CONST_NUM_INT}|{CONST_NUM_REAL}|{CONST_STRING}|{CONST_BASE_BIN})*

%%

<YYINITIAL> {
    "WHILE"                 { return new Symbol(1, new TokenObject("WHILE", yytext())); }
    "IF"                    { return new Symbol(2, new TokenObject("IF", yytext())); }
    "THEN"                  { return new Symbol(3, new TokenObject("THEN", yytext())); }
    "ELSE"                  { return new Symbol(4, new TokenObject("ELSE", yytext())); }
    "ENDIF"                 { return new Symbol(5, new TokenObject("ENDIF", yytext())); }
    "NOT"                   { return new Symbol(7, new TokenObject("NOT", yytext())); }
    "AND"                   { return new Symbol(8, new TokenObject("AND", yytext())); }
    "OR"                    { return new Symbol(9, new TokenObject("OR", yytext())); }
    "DECLARE.SECTION"       { return new Symbol(10, new TokenObject("DECLARE.SECTION", yytext())); }
    "ENDDECLARE.SECTION"    { return new Symbol(11, new TokenObject("ENDDECLARE.SECTION", yytext())); }
    "PROGRAM.SECTION"       { return new Symbol(12, new TokenObject("PROGRAM.SECTION", yytext())); }
    "ENDPROGRAM.SECTION"    { return new Symbol(13, new TokenObject("ENDPROGRAM.SECTION", yytext())); }
    "AsigComp"              { return new Symbol(14, new TokenObject("AsigComp", yytext())); }
    "FLOAT"                 { return new Symbol(15, new TokenObject("FLOAT", yytext())); }
    "INT"                   { return new Symbol(16, new TokenObject("INT", yytext())); }
    "STRING"                { return new Symbol(17, new TokenObject("STRING", yytext())); }

    "\""                    { return new Symbol(18, new TokenObject("Comillas", yytext())); }
    "{"                     { return new Symbol(19, new TokenObject("Llave abierta", yytext())); }
    "}"                     { return new Symbol(20, new TokenObject("Llave cerrada", yytext())); }
    "("                     { return new Symbol(21, new TokenObject("Paréntesis abierto", yytext())); }
    ")"                     { return new Symbol(22, new TokenObject("Paréntesis cerrado", yytext())); }
    "["                     { return new Symbol(23, new TokenObject("Corchetes abierto", yytext())); }
    "]"                     { return new Symbol(24, new TokenObject("Corchetes cerrado", yytext())); }
    "::="                   { return new Symbol(25, new TokenObject("Asignación", yytext())); }
    "="                     { return new Symbol(26, new TokenObject("Asignación simple", yytext())); }
    "//*"                   { return new Symbol(27, new TokenObject("Abre bloque comentario", yytext())); }
    "*//"                   { return new Symbol(28, new TokenObject("Cierra bloque comentario", yytext())); }
    "<"                     { return new Symbol(29, new TokenObject("Menor que", yytext())); }
    ">"                     { return new Symbol(30, new TokenObject("Mayor que", yytext())); }
    ">="                    { return new Symbol(31, new TokenObject("Mayor o igual", yytext())); }
    "<="                    { return new Symbol(32, new TokenObject("Menor o igual", yytext())); }
    "=="                    { return new Symbol(33, new TokenObject("Igual", yytext())); }
    "!="                    { return new Symbol(34, new TokenObject("Diferente", yytext())); }
    ":="                    { return new Symbol(35, new TokenObject("Asignación múltiple", yytext())); }
    ";"                     { return new Symbol(36, new TokenObject("Punto y coma", yytext())); }
    ":"                     { return new Symbol(37, new TokenObject("Dos puntos", yytext())); }
    ","                     { return new Symbol(38, new TokenObject("Coma", yytext())); }
    "."                     { return new Symbol(39, new TokenObject("Punto", yytext())); }
    "+"                     { return new Symbol(40, new TokenObject("Suma", yytext())); }
    "-"                     { return new Symbol(41, new TokenObject("Resta", yytext())); }
    "*"                     { return new Symbol(42, new TokenObject("Multiplicación", yytext())); }
    "/"                     { return new Symbol(43, new TokenObject("División", yytext())); }

    {CONST_STRING}          { return new Symbol(44, new TokenObject("CTE_STR", yytext())); }
    {CONST_NUM_REAL}        { return new Symbol(45, new TokenObject("CTE_F", yytext())); }
    {CONST_NUM_INT}         { return new Symbol(46, new TokenObject("CTE_E", yytext())); }
    {CONST_BASE_BIN}        { return new Symbol(47, new TokenObject("CTE_B", yytext())); }
    {WRITE}                 { return new Symbol(48, new TokenObject("WRITE", yytext())); }
    {ID}                    { return new Symbol(49, new TokenObject("ID", yytext())); }
    {COMENTARIOS}           { }
    {ESPACIO}               { }
    {CONST_STRING_ERROR}    { return new Symbol(1001, new TokenObject("ERROR", yytext())); }
}
[^]                         { return new Symbol(1000, new TokenObject("ERROR", yytext())); }