import SwiftUI

struct ContentView: View {
    @StateObject var api = APIView()
    @StateObject private var viewModel = WalletsViewModel()
    @State private var isCreatingWallet = false
    
    var body: some View {
        NavigationStack {
            if viewModel.isLoading {
                VStack {
                    Spacer()
                    ProgressView("Carregando carteiras...")
                        .progressViewStyle(CircularProgressViewStyle())
                        .padding()
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                VStack {
                    Text("Carteiras")
                        .font(.title)
                        .bold()
                        .padding(.bottom, 30)
                    
                    ScrollView {
                        if viewModel.wallets.isEmpty {
                            Text("Nenhuma carteira encontrada.")
                                .font(.title2)
                                .foregroundColor(.gray)
                                .frame(maxWidth: .infinity, minHeight: 200)
                        } else {
                            ForEach(Array(viewModel.wallets.enumerated()), id: \.element) { index, wallet in
                                NavigationLink(destination: MainTabView(wallet: wallet)) {
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
                                                Text("Carteira - \(index + 1)")
                                                    .font(.headline)
                                                Text(wallet.address.base58)
                                                    .font(.caption2)
                                                    .foregroundColor(.gray)
                                                    .lineLimit(1)
                                                    .truncationMode(.middle)
                                            }
                                            
                                            Spacer()
                                        }
                                    }
                                    .padding()
                                    .background(Color(UIColor.secondarySystemBackground))
                                    .cornerRadius(15)
                                    .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
                                    .padding(.bottom, 8)
                                }
                                .navigationBarBackButtonHidden(true)
                            }
                        }
                    }
                    
                    Button(action: {
                        isCreatingWallet = true
                        api.criarWallet()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            isCreatingWallet = false
                            viewModel.getWallets()
                        }
                    }) {
                        HStack {
                            if isCreatingWallet {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            } else {
                                Text("Gerar Carteira")
                                    .fontWeight(.bold)
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 15)
                        .background(Color("AZUL_CLARO"))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                    .disabled(isCreatingWallet)
                    .padding(.horizontal, 70)
                }
                .padding()
            }
        }
        .onAppear {
            viewModel.getWallets()
        }
    }
}

#Preview {
    ContentView()
}
