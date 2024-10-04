# FlexLexico

## Overview

FlexLexico is a Java-based lexical analyzer project. It reads and processes a file named `prueba.txt` to perform lexical analysis. The results are saved in a file named `ts.txt`.

## Project Structure

- **src/main/java/com/Lexico/FlexLexico**: Contains the main Java classes.
- **prueba.txt**: The input file for the lexical analyzer.
- **ts.txt**: The output file containing the token names and values.
- **pom.xml**: Maven configuration file.

## Prerequisites

- Java 20
- Maven
- java-cup-11b (version 2015.03.26)

## Setup

1. Clone the repository:

   ```sh
   git clone https://github.com/VNardoni/TEO1.git
   cd FlexLexico
   ```

2. Build the project using Maven:
   ```sh
   mvn clean install
   ```

## Build the JAR

To build the .jar file, use the following Maven command:

   ```sh
   mvn clean package
   ```

The resulting .jar file will be located in the target directory

## Usage

Run the main class to start the lexical analyzer. The UI will allow you to load the input file and display the results. The tokens will be saved in ts.txt.

## Authors (Grupo 3)

- Cosentino Matias
- Juarez Sebastian
- **Nardoni Valentin** (Delegado)
- Pittavino Patricio
- Rueda Lucas

## Anexo

[Link Documento REGEX](https://docs.google.com/document/d/1_P1gy3LVajhrFVl_u1IOgZa34uSg5c2fvrE33nPvs7E/edit?usp=sharing)
