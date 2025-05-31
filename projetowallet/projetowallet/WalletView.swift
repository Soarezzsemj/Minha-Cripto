import SwiftUI

struct WalletView: View {
    let wallet: wallet
    @StateObject var api = APIView()

    // Estados
    @State private var isLoadingBalance = true
    @State private var showCopyAlert = false
    @State private var balanceUSD: Double = 0.0
    @State private var destinatario = "TRX47epPKX1DXwYWAor8r7qpAMpU4urpXQ"
    @State private var valorTexto = ""
    @State private var navegarParaSucesso = false
    @State private var hashIdRecebido = ""
    @State private var isSending = false
    
    // Computados
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
            VStack(spacing: 30) {

                                
                carteiraInfoSection

                Spacer()
                Divider()
                // Formulário
                transferFormSection

                // Botão
                enviarButton

                // Navegação pós-sucesso
                NavigationLink(
                    destination: TransferSuccessView(wallet: wallet, hashId: hashIdRecebido),
                    isActive: $navegarParaSucesso,
                    label: { EmptyView() }
                )
                .navigationBarBackButtonHidden(true)

            }
            .padding()
            .padding([.top], 40)
            .alert(isPresented: $showCopyAlert) {
                Alert(
                    title: Text("Copiado!"),
                    message: Text("Endereço copiado para a área de transferência."),
                    dismissButton: .default(Text("OK"))
                )
            }
            .onAppear(perform: fetchWalletInfo)
            .onReceive(api.$respostaTransferencia.compactMap { $0 }) { resposta in
                if resposta.status {
                    hashIdRecebido = resposta.transaction
                    navegarParaSucesso = true
                    destinatario = ""
                    valorTexto = ""
                } else {
                    // Feedback de erro pode ser adicionado aqui
                }
            }
        }
    }

    // MARK: - Seções da View

    private var carteiraInfoSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 16) {
                Image(systemName: "creditcard.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .foregroundColor(Color("AZUL_CLARO"))
                    .padding(10)
                    .background(Color("AZUL_ESCURO").opacity(0.1))
                    .clipShape(Circle())

                VStack(alignment: .leading, spacing: 4) {
                    Text("Carteira").font(.headline)

                    HStack {
                        Text(wallet.address.base58)
                            .font(.caption2)
                            .foregroundColor(.gray)
                            .lineLimit(1)
                            .truncationMode(.middle)

                        Button(action: {
                            UIPasteboard.general.string = wallet.address.base58
                            showCopyAlert = true
                        }) {
                            Image(systemName: "doc.on.doc")
                                .font(.system(size: 12))
                                .foregroundColor(.blue)
                                .padding(.leading, 8)
                        }
                    }

                    if isLoadingBalance {
                        ProgressView()
                            .scaleEffect(0.8)
                            .padding(.top, 4)
                    } else {
                        Text("Saldo: $\(String(format: "%.2f", balanceUSD))")
                            .font(.subheadline)
                            .bold()
                            .foregroundColor(.green)
                    }
                }

                Spacer()
            }
        }
        .padding()
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
    }

    private var transferFormSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Endereço do destinatário:")
                .foregroundColor(.black)
                .padding(.leading, 5)

            TextField("Ex: TXa1...Z9c", text: $destinatario)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .padding()
                .frame(height: 45)
                .background(Color(.systemGray6))
                .cornerRadius(8)

            Text("Valor (USDT):")
                .foregroundColor(.black)
                .padding(.leading, 5)

            TextField("Ex: 10.50", text: $valorTexto)
                .keyboardType(.decimalPad)
                .padding()
                .frame(height: 45)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .onChange(of: valorTexto) {
                    sanitizeValorTexto()
                }
        }
        .frame(width: 320)
    }

    private var enviarButton: some View {
        Button(action: {
            guard let valor = valorConvertido else { return }
            isSending = true
            api.transferir(destinatario: destinatario, valor: valor, privateKey: wallet.privateKey)
        }) {
            HStack {
                if isSending {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .scaleEffect(0.8)
                } else {
                    Text("Enviar")
                        .fontWeight(.bold)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
            .background(camposValidos ? Color("AZUL_CLARO") : Color.gray)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .disabled(!camposValidos || isSending)
        .padding(.horizontal, 70)
    }

    private func sanitizeValorTexto() {
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

    private func fetchWalletInfo() {
        isLoadingBalance = true

        let rawAddress = wallet.address.base58
        guard let encodedAddress = rawAddress.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: "http://192.168.128.112:3002/tether/balance?address=\(encodedAddress)") else {
            isLoadingBalance = false
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: request) { data, _, error in
            defer {
                DispatchQueue.main.async {
                    self.isLoadingBalance = false
                }
            }

            guard let data = data, error == nil else {
                print("Erro na requisição:", error ?? "")
                return
            }

            do {
                let rawBalance = try JSONDecoder().decode(Int.self, from: data)
                let adjustedBalance = Double(rawBalance) / 1_000_000
                DispatchQueue.main.async {
                    self.balanceUSD = adjustedBalance
                }
            } catch {
                print("Erro ao decodificar:", error)
                if let str = String(data: data, encoding: .utf8) {
                    print("Retorno bruto:", str)
                }
            }
        }.resume()
    }
}

#Preview {
    WalletView(wallet: wallet(
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
