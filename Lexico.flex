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

    {CONST_STRING}          { return new Symbol(sym.Cte_s, yytext()); }
    {CONST_NUM_REAL}        { return new Symbol(sym.Cte_f, yytext()); }
    {CONST_NUM_INT}         { return new Symbol(sym.Cte_e, yytext()); }
    {CONST_BASE_BIN}        { return new Symbol(sym.Cte_b, yytext()); }
    {WRITE}                 { return new Symbol(sym.Write, yytext()); }
    {ID}                    { return new Symbol(sym.Id, yytext()); }
    {COMENTARIOS}           { }
    {ESPACIO}               { }
    {CONST_STRING_ERROR}    { return new Symbol(1001, yytext()); }
}
[^]                         { return new Symbol(1000, yytext()); }