//
//  TabView.swift
//  projetowallet
//
//  Created by Ramon Raniere on 21/05/25.
//

import SwiftUI

struct MainTabView: View {
    
    let wallet: wallet
    
    var body: some View {
        TabView{
            WalletView(wallet: wallet)
                .tabItem {
                    Label("Enviar", systemImage: "square.and.arrow.up")
                }
                .navigationBarBackButtonHidden(true)
                .navigationBarHidden(true)
            ReceiveView(wallet: wallet)
                .tabItem {
                    Label("Receber", systemImage: "square.and.arrow.down")
                }
                .navigationBarBackButtonHidden(true)
                .navigationBarHidden(true)
            
            ContentView()
                .tabItem {
                    Label("Carteiras", systemImage: "list.bullet")
                }
                .navigationBarBackButtonHidden(true)
                .navigationBarHidden(true)

            
        }
    }
}

#Preview {
    MainTabView(wallet: wallet(
        _id: "123",
        _rev: "1-abc",
        privateKey: "EB99AC2B54334444192B21D7E7104FDF6E72FAEA8D8734F7E3E6088597A328DD",
        publicKey: "PUBLICKEY456",
        address: address(
            base58: "TC8C9sn6Vm3GPYbqLph4TBYRssHGUZDzSc",
            hex: "4117A34990EA7D273C138313F506D2815E379127FE"
        ),
        status: "p",
        rfID: "163132642"
    ))
}
