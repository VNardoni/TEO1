import java_cup.runtime.Symbol;

%%

%cup
%public
%class Lexico
%line
%column
%char

DIGITO = [0-9]
LETRA_MINUSCULA = [a-z]
LETRA_MAYUSCULA = [A-Z]
LETRA = {LETRA_MINUSCULA}|{LETRA_MAYUSCULA}
CH_ESPECIALES = [¿?¡!#$%&@]
ESPACIO = [ \t\n\r\f]+
CONST_NUM_INT = {DIGITO}+
CONST_NUM_REAL = {DIGITO}*"."{DIGITO}+|{DIGITO}+"."{DIGITO}*
CONST_STRING = "\""({LETRA}|{DIGITO}|{CH_ESPECIALES}|{ESPACIO})*"\""
CONST_BASE_BIN = "0b"(0|1)+
ID = {LETRA_MINUSCULA}({LETRA}|{DIGITO})*
COMENTARIOS = "//*"({LETRA}|{DIGITO}|{CH_ESPECIALES}|{ESPACIO})*"*//"
WRITE = "WRITE"({ID}|{CONST_NUM_INT}|{CONST_NUM_REAL}|{CONST_STRING}|{CONST_BASE_BIN})*

%%

<YYINITIAL> {
    "WHILE" { System.out.println("TOKEN: WHILE"); }
    "IF" { System.out.println("TOKEN: IF"); }
    "THEN" { System.out.println("TOKEN: THEN"); }
    "ELSE" { System.out.println("TOKEN: ELSE"); }
    "ENDIF" { System.out.println("TOKEN: ENDIF"); }
    "WRITE" { System.out.println("TOKEN: WRITE"); }
    "NOT" { System.out.println("TOKEN: NOT"); }
    "AND" { System.out.println("TOKEN: AND"); }
    "OR" { System.out.println("TOKEN: OR"); }
    "DECLARE.SECTION" { System.out.println("TOKEN: DECLARE.SECTION"); }
    "ENDDECLARE.SECTION" { System.out.println("TOKEN: ENDDECLARE.SECTION"); }
    "PROGRAM.SECTION" { System.out.println("TOKEN: PROGRAM.SECTION"); }
    "ENDPROGRAM.SECTION" { System.out.println("TOKEN: ENDPROGRAM.SECTION"); }
    "AsigComp" { System.out.println("TOKEN: AsigComp"); }
    "FLOAT" { System.out.println("TOKEN: FLOAT"); }
    "INT" { System.out.println("TOKEN: INT"); }
    "STRING" { System.out.println("TOKEN: STRING"); }

    "\"" { System.out.println("TOKEN: Comillas"); }
    "{" { System.out.println("TOKEN: Llave abierta"); }
    "}" { System.out.println("TOKEN: Llave cerrada"); }
    "(" { System.out.println("TOKEN: Paréntesis abierto"); }
    ")" { System.out.println("TOKEN: Paréntesis cerrado"); }
    "[" { System.out.println("TOKEN: Corchetes abierto"); }
    "]" { System.out.println("TOKEN: Corchetes cerrado"); }
    "::=" { System.out.println("TOKEN: Asignación"); }
    "=" { System.out.println("TOKEN: Asignación simple"); }
    "//*" { System.out.println("TOKEN: Abre bloque comentario"); }
    "*//" { System.out.println("TOKEN Cierra bloque comentario"); }
    "<" { System.out.println("TOKEN: Menor que"); }
    ">" { System.out.println("TOKEN: Mayor que"); }
    ">=" { System.out.println("TOKEN: Mayor o igual"); }
    "<=" { System.out.println("TOKEN: Menor o igual"); }
    "==" { System.out.println("TOKEN: Igual"); }
    "!=" { System.out.println("TOKEN Diferente"); }
    ":=" { System.out.println("TOKEN: Asignación múltiple"); }
    ";" { System.out.println("TOKEN: Punto y coma"); }
    ":" { System.out.println("TOKEN: Dos puntos"); }
    "," { System.out.println("TOKEN: Coma"); }
    "." { System.out.println("TOKEN: Punto"); }
    "+" { System.out.println("TOKEN: Suma"); }
    "-" { System.out.println("TOKEN: Resta"); }
    "*" { System.out.println("TOKEN: Multiplicación"); }
    "/" { System.out.println("TOKEN: División"); }

    {ID} { System.out.println("TOKEN: ID"); }
    {CONST_NUM_INT} { System.out.println("TOKEN: Entero"); }
    {CONST_NUM_REAL} { System.out.println("TOKEN: Real"); }
    {CONST_STRING} { System.out.println("TOKEN: String"); }
    {CONST_BASE_BIN} { System.out.println("TOKEN: Número binario"); }
    {ESPACIO} { }

}
[^] { throw new Error("Carácter no válido: <" + yytext() + "> en la linea " + yyline); }