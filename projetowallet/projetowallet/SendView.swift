//import SwiftUI
//
//struct SendView: View {
//    @Binding var showSheet: Bool
//    let wallet: wallet
//    let onSuccess: (String) -> Void
//
//    @StateObject var api = APIView()
//    @State private var destinatario = "TW5zHp1cDAbwZfL7snxjQ2QUVcmWv5Ajxd"
//    @State private var valorTexto = ""
//    @State private var mostrarAlerta = false
//    @State private var mensagemAlerta = ""
//
//    var valorConvertido: Double? {
//        Double(valorTexto.replacingOccurrences(of: ",", with: "."))
//    }
//
//    var destinatarioValido: Bool {
//        destinatario.trimmingCharacters(in: .whitespaces).count >= 34
//    }
//
//    var camposValidos: Bool {
//        destinatarioValido && (valorConvertido ?? 0) > 0
//    }
//
//    var body: some View {
//        VStack(spacing: 20) {
//            VStack(alignment: .leading, spacing: 8) {
//                Text("Endereço do destinatário:")
//                    .foregroundColor(.black)
//                    .padding(.leading, 5)
//
//                TextField("Ex: TXa1...Z9c", text: $destinatario)
//                    .autocapitalization(.none)
//                    .disableAutocorrection(true)
//                    .padding()
//                    .frame(width: 320, height: 45)
//                    .background(Color(.systemGray6))
//                    .cornerRadius(8)
//            }
//
//            VStack(alignment: .leading, spacing: 8) {
//                Text("Valor (USDT):")
//                    .foregroundColor(.black)
//                    .padding(.leading, 5)
//
//                TextField("Ex: 10.50", text: $valorTexto)
//                    .keyboardType(.decimalPad)
//                    .padding()
//                    .frame(width: 320, height: 45)
//                    .background(Color(.systemGray6))
//                    .cornerRadius(8)
//                    .onChange(of: valorTexto) {
//                        let filtered = valorTexto.replacingOccurrences(
//                            of: "[^0-9,.]",
//                            with: "",
//                            options: .regularExpression
//                        )
//
//                        let components = filtered.components(separatedBy: CharacterSet(charactersIn: ".,"))
//                        if components.count > 2 {
//                            valorTexto = components[0] + "." + components[1]
//                        } else {
//                            valorTexto = filtered.replacingOccurrences(of: ",", with: ".")
//                        }
//                    }
//            }
//
//            Spacer()
//            
//            
//
//            Button("Enviar") {
//                if let valor = valorConvertido {
//                    api.transferir(destinatario: destinatario, valor: valor, privateKey: wallet.privateKey)
//                    destinatario = ""
//                    valorTexto = ""
//                }
//            }
//            .disabled(!camposValidos)
//            .padding(.horizontal, 70)
//            .padding(.vertical, 15)
//            .foregroundColor(.white)
//            .background(camposValidos ? Color("AZUL_CLARO") : Color.gray)
//            .cornerRadius(10)
//            
//            NavigationLink(
//                destination: TransferSuccessView(wallet: wallet, hashId: hashIdRecebido),
//                label: { EmptyView() }
//            )
//
//            Spacer()
//        }
//        .onReceive(api.$respostaTransferencia.compactMap { $0 }) { resposta in
//            if resposta.status {
//                showSheet = false
//                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//                    onSuccess(resposta.transaction)
//                }
//            } else {
//                mensagemAlerta = "Erro ao transferir. Tente novamente."
//                mostrarAlerta = true
//            }
//        }
//        .alert(isPresented: $mostrarAlerta) {
//            Alert(title: Text("Transferência"), message: Text(mensagemAlerta), dismissButton: .default(Text("OK")))
//        }
//        .padding()
//    }
//}


import SwiftUI

struct SendView: View {
    let wallet: wallet
    @StateObject var api = APIView()

    @State private var destinatario = "TW5zHp1cDAbwZfL7snxjQ2QUVcmWv5Ajxd"
    @State private var valorTexto = ""
    @State private var mostrarAlerta = false
    @State private var mensagemAlerta = ""
    
    @State private var navegarParaSucesso = false
    @State private var hashIdRecebido = ""

    var valorConvertido: Double? {
        Double(valorTexto.replacingOccurrences(of: ",", with: "."))
    }
    
    var destinatarioValido: Bool {
        destinatario.trimmingCharacters(in: .whitespaces).count >= 34
    }
    
    var camposValidos: Bool {
        destinatarioValido && (valorConvertido ?? 0) > 0
    }

    var body: some View {
        NavigationStack {
          
            VStack(spacing: 16) {
                
                Text("Endereço do destinatário:")
                    .foregroundColor(.black)
                    .padding(.leading, 5)

                TextField("Ex: TXa1...Z9c", text: $destinatario)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .padding()
                    .frame(width: 320, height: 45)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
               
                Text("Valor (USDT):")
               .foregroundColor(.black)
               .padding(.leading, 5)

           TextField("Ex: 10.50", text: $valorTexto)
               .keyboardType(.decimalPad)
               .padding()
               .frame(width: 320, height: 45)
               .background(Color(.systemGray6))
               .cornerRadius(8)
               .onChange(of: valorTexto) {
                   let filtered = valorTexto.replacingOccurrences(
                       of: "[^0-9,.]",
                       with: "",
                       options: .regularExpression
                   )

                   let components = filtered.components(separatedBy: CharacterSet(charactersIn: ".,"))
                   if components.count > 2 {
                       valorTexto = components[0] + "." + components[1]
                   } else {
                       valorTexto = filtered.replacingOccurrences(of: ",", with: ".")
                   }
               }

                Button("Enviar") {
                    if let valor = valorConvertido {
                        api.transferir(destinatario: destinatario, valor: valor, privateKey: wallet.privateKey)
                        destinatario = ""
                        valorTexto = ""
                    }
                }
                .disabled(!camposValidos)
                .padding(.horizontal, 70)
                .padding(.vertical, 5)
                .foregroundColor(.white)
                .background(camposValidos ? Color("AZUL_CLARO") : Color.gray)
                .cornerRadius(10)
                .buttonStyle(.borderedProminent)

                NavigationLink(
                    destination: TransferSuccessView(wallet: wallet ,hashId: hashIdRecebido),
                    isActive: $navegarParaSucesso,
                    label: { EmptyView() }
                )
            }
            .padding()
            .alert(isPresented: $mostrarAlerta) {
                Alert(title: Text("Erro"), message: Text(mensagemAlerta), dismissButton: .default(Text("OK")))
            }
            .onReceive(api.$respostaTransferencia.compactMap { $0 }) { resposta in
                if resposta.status {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.hashIdRecebido = resposta.transaction
                        self.navegarParaSucesso = true
                    }
                } else {
                    mensagemAlerta = "Erro ao transferir. Tente novamente."
                    mostrarAlerta = true
                }
            }
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
    
    return SendView(wallet: dummyWallet)
}

