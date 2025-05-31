//
//  modelView.swift
//  desafiomyapi
//
//  Created by Turma02-5 on 07/05/25.
//

import Foundation

class APIView: ObservableObject{
   
    @Published var wallets: [wallet] = []
    @Published var mensagemTransferencia: String? = nil
    @Published var respostaTransferencia: TransferResponse? = nil
    
    func criarWallet() {
        guard let url = URL(string: "http://192.168.128.112:1880/criar-wallet") else {
            return
        }

        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }

            do {
                let parsed = try JSONDecoder().decode(wallet.self, from: data)
                DispatchQueue.main.async {
                    self?.wallets.append(parsed)
                }
            } catch {
                print(error)
            }
        }

        task.resume()
    }
    
   
    func transferir(destinatario: String, valor: Double, privateKey: String) {
                
        guard let url = URL(string: "http://192.168.128.112:1880/transferir") else { return }

        let parametros: [String: Any] = [
            "to_address": destinatario,
            "value": valor,
            "private_key": privateKey
        ]

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parametros, options: [])
        } catch {
            print("Erro ao criar o corpo da requisição:", error)
            return
        }

        URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                print("Erro na requisição:", error ?? "")
                return
            }

            do {
                let resposta = try JSONDecoder().decode(TransferResponse.self, from: data)

                DispatchQueue.main.async {
                    print(resposta)
                    self.respostaTransferencia = resposta
                }
            } catch {
                print("❗️Erro ao decodificar: \(error)")
                if let raw = String(data: data, encoding: .utf8) {
                    print("Resposta crua:", raw)
                }
            }
        }.resume()
    }
}

