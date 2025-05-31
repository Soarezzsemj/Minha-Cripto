//
//  WalletViewModel.swift
//  projetowallet
//
//  Created by Ramon Raniere on 20/05/25.
//

import Foundation

class WalletsViewModel: ObservableObject {
    @Published var wallets: [wallet] = []
    @Published var isLoading: Bool = true
    
    func getWallets() {
        isLoading = true
        
//        guard let url = URL(string: "http://127.0.0.1:1880/get-wallets") else {
        guard let url = URL(string: "http://192.168.128.112:1880/get-wallets") else {
            isLoading = false
            return
        }

        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                    self?.isLoading = false
                }
                return
            }

            do {
                let parsed = try JSONDecoder().decode([wallet].self, from: data)
                DispatchQueue.main.async {
                    self?.wallets = parsed
                    self?.isLoading = false
                }
            } catch {
                DispatchQueue.main.async {
                    self?.isLoading = false
                    print("Erro ao decodificar: \(error)")
                }
            }
        }

        task.resume()
    }
    
    
}
