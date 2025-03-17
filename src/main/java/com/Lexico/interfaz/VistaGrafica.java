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
import java.awt.*;

import com.Lexico.FlexLexico.*;

public class VistaGrafica {

	private JFrame frame;
	private JTextArea inputTextArea;
	private JTextPane consoleArea;
	private JTextPane consoleArea2;
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
		ArrayList<TokenObject> tokenList = new ArrayList<>();
		ArrayList<RuleObject> rulesList = new ArrayList<>();

		frame = new JFrame();
		frame.setBounds(100, 100, 1024, 720); // Ajustamos la altura máxima del JFrame
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		frame.getContentPane().setLayout(new BorderLayout());

		// Título
		JLabel lblTitulo = new JLabel("Analizador Léxico Gráfico", SwingConstants.CENTER);
		lblTitulo.setFont(new Font("Segoe UI Semibold", Font.BOLD, 30));
		frame.getContentPane().add(lblTitulo, BorderLayout.NORTH);

		// Panel principal dividido
		JSplitPane splitPanePrincipal = new JSplitPane(JSplitPane.HORIZONTAL_SPLIT);
		splitPanePrincipal.setDividerLocation(600); // Ancho inicial del área de texto
		frame.getContentPane().add(splitPanePrincipal, BorderLayout.CENTER);

		// Área de entrada de texto
		inputTextArea = new JTextArea();
		JScrollPane scrollPaneInput = new JScrollPane(inputTextArea);
		splitPanePrincipal.setLeftComponent(scrollPaneInput);

		// Panel de consolas dividido
		JSplitPane splitPaneConsolas = new JSplitPane(JSplitPane.VERTICAL_SPLIT);
		splitPaneConsolas.setDividerLocation(350); // Altura inicial para la primera consola
		splitPanePrincipal.setRightComponent(splitPaneConsolas);

		// Consola 1
		consoleArea = new JTextPane();
		consoleArea.setEditable(false);
		consoleArea.setBackground(new Color(30, 30, 30));
		consoleArea.setForeground(Color.GREEN);
		consoleArea.setFont(new Font("Monospaced", Font.PLAIN, 14));
		JScrollPane consoleScrollPane = new JScrollPane(consoleArea);
		splitPaneConsolas.setTopComponent(consoleScrollPane);

		// Consola 2
		consoleArea2 = new JTextPane();
		consoleArea2.setEditable(false);
		consoleArea2.setBackground(new Color(30, 30, 30));
		consoleArea2.setForeground(Color.GREEN);
		consoleArea2.setFont(new Font("Monospaced", Font.PLAIN, 14));
		JScrollPane consoleScrollPane2 = new JScrollPane(consoleArea2);
		splitPaneConsolas.setBottomComponent(consoleScrollPane2);

		// Panel inferior para los botones
		JPanel panelBotones = new JPanel();
		panelBotones.setLayout(new FlowLayout(FlowLayout.CENTER, 20, 10));
		frame.getContentPane().add(panelBotones, BorderLayout.SOUTH);

		// Botón "Cargar Archivo"
		JButton btnCargarArchivo = new JButton("Cargar archivo");
		btnCargarArchivo.setFont(new Font("Tahoma", Font.PLAIN, 15));
		panelBotones.add(btnCargarArchivo);

		// Botón "Limpiar"
		JButton btnClear = new JButton("Limpiar");
		btnClear.setFont(new Font("Tahoma", Font.PLAIN, 15));
		panelBotones.add(btnClear);

		// Botón "Analizar"
		JButton btnAnalizar = new JButton("Analizar");
		btnAnalizar.setFont(new Font("Tahoma", Font.PLAIN, 15));
		panelBotones.add(btnAnalizar);

		// Listeners
		btnCargarArchivo.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				cargarArchivo();
			}
		});

		btnClear.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				inputTextArea.setText("");
				consoleArea.setText("");
				consoleArea2.setText(""); // Limpiar también consoleArea2
			}
		});

		btnAnalizar.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				try {
					tokenList.clear();
					rulesList.clear();
					TokenRulesObject tokenRules = FlexLexico.analizar(inputTextArea.getText());
					tokenList.addAll(tokenRules.tokenList());
					rulesList.addAll(tokenRules.rulesList());
					printTokens(tokenList);
					printRules(rulesList);
					saveTsFile(tokenList);
				} catch (Exception e1) {
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

	private void printRules(ArrayList<RuleObject> rulesList) {
		StringBuilder sb = new StringBuilder();
		sb.append("<html><body>");
		for (RuleObject rule : rulesList) {
			sb.append("<span style='color:#ADD8E6;'>[RULE ").append(rule.ruleNumber()).append("]: </span>")
					.append("<span style='color:yellow;'>")
					.append(rule.start());
			for (RuleItem item : rule.rules()) {
				sb.append(" ");
				sb.append(item.type().equals(RuleType.T)
							? "<span style='color:orange;'>"
							: "<span style='color:yellow;'>"
				).append(item.value());
			}
			sb.append("</span>")
			.append("<br>");
		}
		sb.append("</body></html>");
		consoleArea2.setContentType("text/html");
		consoleArea2.setText(sb.toString());
	}

	private void saveTsFile(ArrayList<TokenObject> tokenList) {
		ArrayList<TokenObject> uniqueTokens = removeDuplicatesByName(tokenList);
		int columnWidth = 40; // Define a fixed width for each column
		File file = new File("ts.txt");
		List<String> constValidTokenNames = Arrays.asList("Cte_s", "Cte_f", "Cte_i", "Cte_b");
		StringBuilder sb = new StringBuilder();
		sb.append(String.format("%-" + columnWidth + "s\t%-" + columnWidth + "s\t%-" + columnWidth + "s\t%-" + columnWidth + "s\n", "NOMBRE", "TOKEN", "TIPO", "VALOR"));
		uniqueTokens.stream()
				.filter(token -> token.name().equals("ID"))
				.forEach(token -> sb.append(String.format("%-" + columnWidth + "s\t%-" + columnWidth +  "s\t%-" + columnWidth + "s\t\n", token.value(), token.name(), token.type().isPresent() ? token.type().get() : "")));
		uniqueTokens.stream()
				.filter(token -> constValidTokenNames.contains(token.name()))
				.filter(this::validateTokenValue)
				.forEach(token -> {
						sb.append(String.format("%-" + columnWidth + "s\t%-" + columnWidth + "s\t%-" + columnWidth + "s\t%-" + columnWidth + "s\n", "_" + token.value(), token.name(), "" , token.value()));
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

	private ArrayList<TokenObject> removeDuplicatesByName(ArrayList<TokenObject> tokenList) {
		ArrayList<TokenObject> uniqueTokens = new ArrayList<>();
		for (TokenObject token : tokenList) {
			if (uniqueTokens.stream().noneMatch(t -> t.value().equals(token.value()))) {
				uniqueTokens.add(token);
			}
		}
		return uniqueTokens;
	}
}