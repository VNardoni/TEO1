package com.Lexico.interfaz;

import java.awt.EventQueue;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.JTextArea;
import javax.swing.JScrollPane;
import javax.swing.JFileChooser;
import javax.swing.JOptionPane;

public class VistaGrafica {

    private JFrame frame;
    private JTextArea textArea;

    /**
     * Launch the application.
     */
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

    /**
     * Create the application.
     */
    public VistaGrafica() {
        initialize();
    }

    /**
     * Initialize the contents of the frame.
     */
    private void initialize() {
        frame = new JFrame();
        frame.setBounds(100, 100, 709, 564);
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.getContentPane().setLayout(null);

        JPanel contenedorPrincipal = new JPanel();
        contenedorPrincipal.setBounds(0, 0, 693, 525);
        frame.getContentPane().add(contenedorPrincipal);
        contenedorPrincipal.setLayout(null);

        // Crear el JTextArea y agregarlo dentro de un JScrollPane
        textArea = new JTextArea();
        JScrollPane scrollPane = new JScrollPane(textArea);
        scrollPane.setBounds(80, 173, 527, 275);
        contenedorPrincipal.add(scrollPane);

        // Crear un botón para cargar el archivo
        JButton btnCargarArchivo = new JButton("Cargar archivo");
        btnCargarArchivo.setBounds(80, 120, 150, 30); // Posicionar el botón sobre el JTextArea
        contenedorPrincipal.add(btnCargarArchivo);

        // Acción al presionar el botón de cargar archivo
        btnCargarArchivo.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent e) {
                cargarArchivo();
            }
        });
    }

    /**
     * Método para cargar un archivo de texto y mostrar su contenido en el JTextArea.
     */
    private void cargarArchivo() {
        JFileChooser fileChooser = new JFileChooser();
        int result = fileChooser.showOpenDialog(frame);
        if (result == JFileChooser.APPROVE_OPTION) {
            File selectedFile = fileChooser.getSelectedFile();
            try (BufferedReader reader = new BufferedReader(new FileReader(selectedFile))) {
                textArea.read(reader, null); // Cargar el contenido directamente al JTextArea
            } catch (Exception e) {
                JOptionPane.showMessageDialog(frame, "Error al cargar el archivo", "Error", JOptionPane.ERROR_MESSAGE);
            }
        }
    }
}

