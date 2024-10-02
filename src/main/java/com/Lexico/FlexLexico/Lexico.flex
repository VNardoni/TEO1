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
    "WHILE" { return new Symbol(1, "WHILE"); }
    "IF" { return new Symbol(2, "IF"); }
    "THEN" { return new Symbol(3, "THEN"); }
    "ELSE" { return new Symbol(4, "ELSE"); }
    "ENDIF" { return new Symbol(5, "ENDIF"); }
    "WRITE" { return new Symbol(6, "WRITE"); }
    "NOT" { return new Symbol(7, "NOT"); }
    "AND" { return new Symbol(8, "AND"); }
    "OR" { return new Symbol(9, "OR"); }
    "DECLARE.SECTION" { return new Symbol(10, "DECLARE.SECTION"); }
    "ENDDECLARE.SECTION" { return new Symbol(11, "ENDDECLARE.SECTION"); }
    "PROGRAM.SECTION" { return new Symbol(12, "PROGRAM.SECTION"); }
    "ENDPROGRAM.SECTION" { return new Symbol(13, "ENDPROGRAM.SECTION"); }
    "AsigComp" { return new Symbol(14, "AsigComp"); }
    "FLOAT" { return new Symbol(15, "FLOAT"); }
    "INT" { return new Symbol(16, "INT"); }
    "STRING" { return new Symbol(17, "STRING"); }

    "\"" { return new Symbol(18, "Comillas"); }
    "{" { return new Symbol(19, "Llave abierta"); }
    "}" { return new Symbol(20, "Llave cerrada"); }
    "(" { return new Symbol(21, "Paréntesis abierto"); }
    ")" { return new Symbol(22, "Paréntesis cerrado"); }
    "[" { return new Symbol(23, "Corchetes abierto"); }
    "]" { return new Symbol(24, "Corchetes cerrado"); }
    "::=" { return new Symbol(25, "Asignación"); }
    "=" { return new Symbol(26, "Asignación simple"); }
    "//*" { return new Symbol(27, "Abre bloque comentario"); }
    "*//" { return new Symbol(28, "Cierra bloque comentario"); }
    "<" { return new Symbol(29, "Menor que"); }
    ">" { return new Symbol(30, "Mayor que"); }
    ">=" { return new Symbol(31, "Mayor o igual"); }
    "<=" { return new Symbol(32, "Menor o igual"); }
    "==" { return new Symbol(33, "Igual"); }
    "!=" { return new Symbol(34, "Diferente"); }
    ":=" { return new Symbol(35, "Asignación múltiple"); }
    ";" { return new Symbol(36, "Punto y coma"); }
    ":" { return new Symbol(37, "Dos puntos"); }
    "," { return new Symbol(38, "Coma"); }
    "." { return new Symbol(39, "Punto"); }
    "+" { return new Symbol(40, "Suma"); }
    "-" { return new Symbol(41, "Resta"); }
    "*" { return new Symbol(42, "Multiplicación"); }
    "/" { return new Symbol(43, "División"); }

    {ID} { return new Symbol(44, "ID"); }
    {CONST_NUM_INT} { return new Symbol(45, "CTE_E"); }
    {CONST_NUM_REAL} { return new Symbol(46, "CTE_F"); }
    {CONST_STRING} { return new Symbol(47, "CTE_STR"); }
    {CONST_BASE_BIN} { return new Symbol(48, "CTE_B"); }
    {ESPACIO} { }

}
[^] { throw new Error("Carácter no válido: <" + yytext() + "> en la linea " + yyline); }