package com.Lexico.interfaz;

import java.awt.EventQueue;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.Color;
import java.awt.Font;
import java.io.*;
import javax.swing.*;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import com.Lexico.FlexLexico.FlexLexico;
import com.Lexico.FlexLexico.TokenObject;

public class VistaGrafica {

	private JFrame frame;
	private JTextArea inputTextArea;
	private JTextPane consoleArea;
	private File archivoSeleccionado;

	public static void main(String[] args) {
		EventQueue.invokeLater(new Runnable() {
			public void run() {
				try {
					VistaGrafica window = new VistaGrafica();
					window.frame.setVisible(true);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		});
	}

	public VistaGrafica() {
		initialize();
	}

	private void initialize() {
		ArrayList<TokenObject> tokenList = new ArrayList<TokenObject>();
		frame = new JFrame();
		frame.setBounds(100, 100, 822, 860);
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		frame.getContentPane().setLayout(null);

		JPanel contenedorPrincipal = new JPanel();
		contenedorPrincipal.setBounds(0, 0, 806, 800);
		frame.getContentPane().add(contenedorPrincipal);
		contenedorPrincipal.setLayout(null);

		inputTextArea = new JTextArea();
		JScrollPane scrollPane = new JScrollPane(inputTextArea);
		scrollPane.setBounds(28, 120, 750, 400);
		contenedorPrincipal.add(scrollPane);

		consoleArea = new JTextPane();
		consoleArea.setEditable(false);
		consoleArea.setBackground(new Color(30, 30, 30));
		consoleArea.setForeground(Color.GREEN);
		consoleArea.setFont(new Font("Monospaced", Font.PLAIN, 14));
		JScrollPane consoleScrollPane = new JScrollPane(consoleArea);
		consoleScrollPane.setBounds(28, 530, 750, 200);
		contenedorPrincipal.add(consoleScrollPane);

		JButton btnCargarArchivo = new JButton("Cargar archivo");
		btnCargarArchivo.setFont(new Font("Tahoma", Font.PLAIN, 15));
		btnCargarArchivo.setBounds(286, 64, 234, 42);
		contenedorPrincipal.add(btnCargarArchivo);

		JLabel lblTitulo = new JLabel("Analizador Léxico Gráfico");
		lblTitulo.setHorizontalAlignment(SwingConstants.CENTER);
		lblTitulo.setFont(new Font("Segoe UI Semibold", Font.BOLD, 30));
		lblTitulo.setBounds(140, 11, 527, 42);
		contenedorPrincipal.add(lblTitulo);

		JButton btnClear = new JButton("Limpiar");
		btnClear.setFont(new Font("Tahoma", Font.PLAIN, 15));
		btnClear.setBounds(200, 743, 180, 40);
		contenedorPrincipal.add(btnClear);

		JButton btnAnalizar = new JButton("Analizar");
		btnAnalizar.setFont(new Font("Tahoma", Font.PLAIN, 15));
		btnAnalizar.setBounds(440, 743, 180, 40);
		contenedorPrincipal.add(btnAnalizar);

		btnCargarArchivo.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				cargarArchivo();
			}
		});

		btnClear.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				inputTextArea.setText("");
				consoleArea.setText("");
			}
		});

		btnAnalizar.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				try {
					tokenList.clear();
					tokenList.addAll(FlexLexico.analizar(inputTextArea.getText()));
					printTokens(tokenList);
					saveTsFile(tokenList);
				} catch (IOException e1) {
					e1.printStackTrace();
				}
			}
		});
	}

	/**
	 * Método para cargar un archivo de texto y mostrar su contenido en el
	 * JTextArea.
	 */
	private void cargarArchivo() {
		JFileChooser fileChooser = new JFileChooser();
		int result = fileChooser.showOpenDialog(frame);
		if (result == JFileChooser.APPROVE_OPTION) {
			archivoSeleccionado = fileChooser.getSelectedFile(); // Guardar el archivo seleccionado
			try (BufferedReader reader = new BufferedReader(new FileReader(archivoSeleccionado))) {
				inputTextArea.read(reader, null); // Cargar el contenido directamente al JTextArea
			} catch (Exception e) {
				JOptionPane.showMessageDialog(frame, "Error al cargar el archivo", "Error", JOptionPane.ERROR_MESSAGE);
			}
		}
	}

	/**
	 * Método para imprimir los tokens en el JTextArea de la consola.
	 */
	private void printTokens(ArrayList<TokenObject> tokenList) {
		StringBuilder sb = new StringBuilder();
		sb.append("<html><body style='color:green;'>");
		for (TokenObject token : tokenList) {
			if (token.name().equals("ERROR")) {
				sb.append("<span style='color:red;'>ERROR: Caracter no válido ")
						.append("<span style='color:orange;'>")
						.append(token.value())
						.append("</span>")
						.append(" </span><br>");
			} else {
				sb.append("[TOKEN]: ")
						.append("<span style='color:yellow;'>")
						.append(token.name())
						.append("</span>")
						.append("&emsp;&emsp;[LEXEMA]: ")
						.append("<span style='color:orange;'>")
						.append(token.value())
						.append("</span>")
						.append("<br>");
			}
		}
		sb.append("</body></html>");
		consoleArea.setContentType("text/html");
		consoleArea.setText(sb.toString());
	}

	private void saveTsFile(ArrayList<TokenObject> tokenList) {
		int columnWidth = 40; // Define a fixed width for each column
		File file = new File("ts.txt");
		List<String> constValidTokenNames = Arrays.asList("CTE_STR", "CTE_F", "CTE_E", "CTE_B");
		StringBuilder sb = new StringBuilder();
		sb.append(String.format("%-" + columnWidth + "s\t%-" + columnWidth + "s\t%-" + columnWidth + "s\n", "NOMBRE", "TOKEN", "VALOR"));
		tokenList.stream()
				.filter(token -> token.name().equals("ID"))
				.forEach(token -> sb.append(String.format("%-" + columnWidth + "s\t%-" + columnWidth + "s\t\n", token.value(), token.name())));
		tokenList.stream()
				.filter(token -> constValidTokenNames.contains(token.name()))
				.forEach(token -> {
					if(validateTokenValue(token))
						sb.append(String.format("%-" + columnWidth + "s\t%-" + columnWidth + "s\t%-" + columnWidth + "s\n", "_" + token.value(), token.name(), token.value()));
				});
		try (FileWriter writer = new FileWriter(file)) {
			writer.write(sb.toString());
		} catch (IOException e) {
			JOptionPane.showMessageDialog(frame, "Error al guardar el archivo", "Error", JOptionPane.ERROR_MESSAGE);
		}
	}

	private boolean validateTokenValue(TokenObject token) {
        return switch (token.name()) {
            case "CTE_STR" -> token.value().length() <= 30;
            case "CTE_F" ->
                    Float.parseFloat(token.value()) >= -Float.MAX_VALUE && Float.parseFloat(token.value()) <= Float.MAX_VALUE;
            case "CTE_E" -> Integer.parseInt(token.value()) >= -32768 && Integer.parseInt(token.value()) <= 32767;
            default -> true;
        };
	}

}