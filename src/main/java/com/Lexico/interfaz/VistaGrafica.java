package com.Lexico.interfaz;

import java.awt.EventQueue;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.JTextArea;
import javax.swing.JScrollPane;
import javax.swing.JFileChooser;
import javax.swing.JOptionPane;
import javax.swing.JLabel;
import java.awt.Font;
import javax.swing.SwingConstants;

import com.Lexico.FlexLexico.FlexLexico;

public class VistaGrafica {

	private JFrame frame;
	private JTextArea textArea;
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
		frame = new JFrame();
		frame.setBounds(100, 100, 822, 860);
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		frame.getContentPane().setLayout(null);

		JPanel contenedorPrincipal = new JPanel();
		contenedorPrincipal.setBounds(0, 0, 806, 821);
		frame.getContentPane().add(contenedorPrincipal);
		contenedorPrincipal.setLayout(null);

		textArea = new JTextArea();
		JScrollPane scrollPane = new JScrollPane(textArea);
		scrollPane.setBounds(28, 173, 750, 543);
		contenedorPrincipal.add(scrollPane);

		JButton btnCargarArchivo = new JButton("Cargar archivo");
		btnCargarArchivo.setBounds(285, 120, 234, 42);
		contenedorPrincipal.add(btnCargarArchivo);

		JLabel lblTitulo = new JLabel("Analizador Lexico Grafico");
		lblTitulo.setHorizontalAlignment(SwingConstants.CENTER);
		lblTitulo.setFont(new Font("Segoe UI Semibold", Font.BOLD, 20));
		lblTitulo.setBounds(139, 51, 527, 42);
		contenedorPrincipal.add(lblTitulo);

		JButton btnAnalizar = new JButton("Analizar");
		btnAnalizar.setBounds(286, 743, 234, 48);
		contenedorPrincipal.add(btnAnalizar);

		btnCargarArchivo.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				cargarArchivo();
			}
		});

		btnAnalizar.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				guardarCambios();
				try {
					FlexLexico.analizar();
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
				textArea.read(reader, null); // Cargar el contenido directamente al JTextArea
			} catch (Exception e) {
				JOptionPane.showMessageDialog(frame, "Error al cargar el archivo", "Error", JOptionPane.ERROR_MESSAGE);
			}
		}
	}

	/**
	 * Método para guardar los cambios en el archivo "prueba.txt".
	 */
	private void guardarCambios() {
		File file = new File("prueba.txt");
			try (FileWriter writer = new FileWriter(file)) {
				textArea.write(writer); // Guardar el contenido del JTextArea en el archivo
			} catch (IOException e) {
				JOptionPane.showMessageDialog(frame, "Error al guardar el archivo", "Error", JOptionPane.ERROR_MESSAGE);
			}
	}
}