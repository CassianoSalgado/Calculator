//
//  ViewController.swift
//  Calculadora
//
//  Created by Cassiano Carradore Salgado on 03/09/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var visorCalculos: UILabel!
    @IBOutlet weak var visor: UILabel!
    @IBOutlet var botoes: [UIButton]!
    
    
    var primeiroNumero = 0.0
    var calculoFinal = ""
    var numeroAtual:String = ""
    var inputValido = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for botao in botoes {
            botao.layer.cornerRadius = 10
        }
        limpaTudo()
    }
    
    func limpaTudo() {
        numeroAtual = ""
        visorCalculos.text = ""
        visor.text = ""
    }
    
    func formatarResultado(resultado: Double) -> String {
        if(resultado.truncatingRemainder(dividingBy: 1) == 0) {
            return String(format: "%.0f", resultado)
            
        } else {
            return String(format: "%.1f", resultado)
        }
    }
    
    func adicionarAoNumero(value: String) {
        numeroAtual = numeroAtual + value
        visorCalculos.text = numeroAtual
    }
    
    func transformaEmDouble() {
        if let doubleNumero = Double(numeroAtual) {
            if primeiroNumero == 0 {
                primeiroNumero = doubleNumero
            }
            numeroAtual = "\(doubleNumero)"
        }
    }
    
    func gerarAlerta() {
        let alert = UIAlertController(title: "Operação inválida", message: "A operação selecionada não está disponível", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func botaoApertado(_ sender: UIButton) {
        guard let textoBotao = sender.titleLabel?.text else {
            return
        }
        switch textoBotao {
            case "AC":
                limpaTudo()
                inputValido = false
            case "C":
                if(!numeroAtual.isEmpty) {
                    numeroAtual.removeLast()
                    visor.text = numeroAtual
                    inputValido = false
                }
            case "=":
                if numeroAtual.last == "+" || numeroAtual.last == "-" || numeroAtual.last == "*" || numeroAtual.last == "/" || numeroAtual.last == "." {
                    numeroAtual = String(numeroAtual.dropLast())
                }
                    transformaEmDouble()
                    let expressao = NSExpression(format: numeroAtual)
                    let resultado = expressao.expressionValue(with: nil, context: nil) as! Double
                    let stringResultante = formatarResultado(resultado: resultado)
                    visor.text = stringResultante
            case "X":
                if inputValido {
                    gerarAlerta()
                } else {
                    adicionarAoNumero(value: "*")
                    inputValido = true
                }
            case "+":
            if inputValido {
                gerarAlerta()
            } else {
                adicionarAoNumero(value: textoBotao)
                inputValido = true
            }
            case ",":
            if inputValido {
                gerarAlerta()
            } else {
                adicionarAoNumero(value: ".")
            }
            case "/":
            if inputValido {
                gerarAlerta()
            } else {
                transformaEmDouble()
                adicionarAoNumero(value: textoBotao)
                inputValido = true
            }
            case "-":
            if inputValido {
                gerarAlerta()
            } else {
                adicionarAoNumero(value: textoBotao)
                inputValido = true
            }
            default:
                adicionarAoNumero(value: textoBotao)
                inputValido = false
        }
    }
}

