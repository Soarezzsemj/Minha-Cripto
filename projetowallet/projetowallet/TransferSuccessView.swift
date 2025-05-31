//
//  TransferSuccessView.swift
//  projetowallet
//
//  Created by Ramon Raniere on 21/05/25.
//
import SwiftUI

struct TransferSuccessView: View {
    let wallet : wallet
    let hashId: String
    @State private var showCopyAlert = false

    var body: some View {
        NavigationStack() {

            Text("Transação Confirmada!")
                .font(.title)
                .bold()
                .multilineTextAlignment(.center)
                .padding()
            
            Text("Sua transação foi registrada com sucesso na blockchain.")
                .multilineTextAlignment(.center)
                .font(.body)
                .foregroundStyle(.gray)

            
            Spacer()
            
            VStack {
                Image(systemName: "checkmark.circle.fill")
                    .font(.system(size: 150))
                    .foregroundColor(.green)
            }
            
            Spacer()
            
            VStack {
               
                Button(action: {
                    UIPasteboard.general.string = hashId
                    showCopyAlert = true
                }) {
                    Label("Copiar Hash", systemImage: "doc.on.doc")
                        .foregroundColor(.blue)
                }
                
                Text(hashId)
                    .font(.body)
                    .foregroundColor(.gray)
                    .lineLimit(1)
                    .truncationMode(.middle)
                    .padding(.horizontal)

                
                
                VStack{
                    
                    NavigationLink(destination: MainTabView(wallet: wallet)){
                        Text("Voltar para carteira")
                            .foregroundColor(.black)
                            .bold()
                            .frame(width: 210, height: 50)
                            .overlay{
                                RoundedRectangle(cornerRadius: 10)
                                .stroke(.black, lineWidth: 1)
                            }
                           
                    }
                    
                    Button(action: {
                        if let url = URL(string: "https://shasta.tronscan.org/#/transaction/\(hashId)") {
                            UIApplication.shared.open(url)
                        }
                    }) {
                        Text("Ver transação")
                            .foregroundColor(.white)
                            .bold()
                            .frame(width: 210, height: 50)
                            .background(Color("AZUL_CLARO"))
                            .cornerRadius(10)
                    }
                    
                    
                }
            }

        }
        .navigationBarHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .padding()
        .alert(isPresented: $showCopyAlert) {
            Alert(title: Text("Copiado!"), message: Text("Hash da transação copiado para a área de transferência."), dismissButton: .default(Text("OK")))
        }
    }
}

#Preview {
    let dummyWallet = wallet(
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
    )
    
    return TransferSuccessView(wallet: dummyWallet, hashId: "04DC3E04AC08557B142B31AD30EDE0A048E2B1ED1AA2851C55FBA3248211338BA4F9A67F254E1D6BF6DBC908F88BF1635AD05321A20269E2B5CF42382B1E85E24A"
    )
}
