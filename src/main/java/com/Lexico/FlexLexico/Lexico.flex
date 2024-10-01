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
    "WHILE" { return new Symbol(1, "TOKEN: WHILE"); }
    "IF" { return new Symbol(2, "TOKEN: IF"); }
    "THEN" { return new Symbol(3, "TOKEN: THEN"); }
    "ELSE" { return new Symbol(4, "TOKEN: ELSE"); }
    "ENDIF" { return new Symbol(5, "TOKEN: ENDIF"); }
    "WRITE" { return new Symbol(6, "TOKEN: WRITE"); }
    "NOT" { return new Symbol(7, "TOKEN: NOT"); }
    "AND" { return new Symbol(8, "TOKEN: AND"); }
    "OR" { return new Symbol(9, "TOKEN: OR"); }
    "DECLARE.SECTION" { return new Symbol(10, "TOKEN: DECLARE.SECTION"); }
    "ENDDECLARE.SECTION" { return new Symbol(11, "TOKEN: ENDDECLARE.SECTION"); }
    "PROGRAM.SECTION" { return new Symbol(12, "TOKEN: PROGRAM.SECTION"); }
    "ENDPROGRAM.SECTION" { return new Symbol(13, "TOKEN: ENDPROGRAM.SECTION"); }
    "AsigComp" { return new Symbol(14, "TOKEN: AsigComp"); }
    "FLOAT" { return new Symbol(15, "TOKEN: FLOAT"); }
    "INT" { return new Symbol(16, "TOKEN: INT"); }
    "STRING" { return new Symbol(17, "TOKEN: STRING"); }

    "\"" { return new Symbol(18, "TOKEN: Comillas"); }
    "{" { return new Symbol(19, "TOKEN: Llave abierta"); }
    "}" { return new Symbol(20, "TOKEN: Llave cerrada"); }
    "(" { return new Symbol(21, "TOKEN: Paréntesis abierto"); }
    ")" { return new Symbol(22, "TOKEN: Paréntesis cerrado"); }
    "[" { return new Symbol(23, "TOKEN: Corchetes abierto"); }
    "]" { return new Symbol(24, "TOKEN: Corchetes cerrado"); }
    "::=" { return new Symbol(25, "TOKEN: Asignación"); }
    "=" { return new Symbol(26, "TOKEN: Asignación simple"); }
    "//*" { return new Symbol(27, "TOKEN: Abre bloque comentario"); }
    "*//" { return new Symbol(28, "TOKEN Cierra bloque comentario"); }
    "<" { return new Symbol(29, "TOKEN: Menor que"); }
    ">" { return new Symbol(30, "TOKEN: Mayor que"); }
    ">=" { return new Symbol(31, "TOKEN: Mayor o igual"); }
    "<=" { return new Symbol(32, "TOKEN: Menor o igual"); }
    "==" { return new Symbol(33, "TOKEN: Igual"); }
    "!=" { return new Symbol(34, "TOKEN Diferente"); }
    ":=" { return new Symbol(35, "TOKEN: Asignación múltiple"); }
    ";" { return new Symbol(36, "TOKEN: Punto y coma"); }
    ":" { return new Symbol(37, "TOKEN: Dos puntos"); }
    "," { return new Symbol(38, "TOKEN: Coma"); }
    "." { return new Symbol(39, "TOKEN: Punto"); }
    "+" { return new Symbol(40, "TOKEN: Suma"); }
    "-" { return new Symbol(41, "TOKEN: Resta"); }
    "*" { return new Symbol(42, "TOKEN: Multiplicación"); }
    "/" { return new Symbol(43, "TOKEN: División"); }

    {ID} { return new Symbol(44, "TOKEN: ID"); }
    {CONST_NUM_INT} { return new Symbol(45, "TOKEN: Entero"); }
    {CONST_NUM_REAL} { return new Symbol(46, "TOKEN: Real"); }
    {CONST_STRING} { return new Symbol(47, "TOKEN: String"); }
    {CONST_BASE_BIN} { return new Symbol(48, "TOKEN: Número binario"); }
    {ESPACIO} { }

}
[^] { throw new Error("Carácter no válido: <" + yytext() + "> en la linea " + yyline); }