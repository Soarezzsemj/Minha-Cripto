import SwiftUI

struct teste: View {
    let tem = true
    @State var showSheet = false
    @State private var selectedTab = 0 // Controla qual botão está selecionado
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    // Seu conteúdo existente...
                    // ... (mantenha todo o conteúdo que você já tem)
                }
                .padding()
            }
        }
        .onAppear {
            showSheet = true
        }
        .sheet(isPresented: $showSheet) {
            VStack(spacing: 0) {
                // PARTE SUPERIOR FIXA (ícones)
                VStack(spacing: 10) {
                    Text("Escolha uma opção")
                        .font(.title2)
                        .bold()
                    
                    Divider()
                    
                    HStack(spacing: 30) {
                        // Botão 1 - QR Code
                        Button(action: {
                            selectedTab = 0
                        }) {
                            VStack {
                                Image(systemName: "qrcode")
                                    .font(.system(size: 24))
                                    .padding(15)
                                    .background(selectedTab == 0 ? Color.blue.opacity(0.2) : Color.gray.opacity(0.1))
                                    .clipShape(Circle())
                                Text("QR Code")
                                    .font(.caption)
                            }
                        }
                        .foregroundColor(selectedTab == 0 ? .blue : .gray)
                        
                        // Botão 2 - Enviar
                        Button(action: {
                            selectedTab = 1
                        }) {
                            VStack {
                                Image(systemName: "arrow.up.right")
                                    .font(.system(size: 24))
                                    .padding(15)
                                    .background(selectedTab == 1 ? Color.green.opacity(0.2) : Color.gray.opacity(0.1))
                                    .clipShape(Circle())
                                Text("Enviar")
                                    .font(.caption)
                            }
                        }
                        .foregroundColor(selectedTab == 1 ? .green : .gray)
                        
                        // Botão 3 - Receber
                        Button(action: {
                            selectedTab = 2
                        }) {
                            VStack {
                                Image(systemName: "arrow.down.left")
                                    .font(.system(size: 24))
                                    .padding(15)
                                    .background(selectedTab == 2 ? Color.orange.opacity(0.2) : Color.gray.opacity(0.1))
                                    .clipShape(Circle())
                                Text("Receber")
                                    .font(.caption)
                            }
                        }
                        .foregroundColor(selectedTab == 2 ? .orange : .gray)
                    }
                    .padding(.vertical)
                }
                .padding()
                
                Divider()
                
                // PARTE INFERIOR DINÂMICA (conteúdo que muda)
                Group {
                    switch selectedTab {
                    case 0:
                        QRCodeView()
                    case 1:
                        EnviarView()
                    case 2:
                        ReceberView()
                    default:
                        EmptyView()
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .presentationDetents([.medium])
            .presentationDragIndicator(.hidden)
            .interactiveDismissDisabled(true)
        }
    }
}

// Views para cada seção (adicione conforme necessário)
struct QRCodeView: View {
    var body: some View {
        VStack {
            Text("Conteúdo do QR Code")
                .font(.title3)
                .padding()
            
            // Adicione aqui o conteúdo específico do QR Code
            Image(systemName: "qrcode")
                .font(.system(size: 100))
                .padding()
            
            Spacer()
        }
    }
}

struct EnviarView: View {
    var body: some View {
        VStack {
            Text("Enviar Criptomoeda")
                .font(.title3)
                .padding()
            
            // Adicione aqui o conteúdo específico para enviar
            TextField("Endereço de destino", text: .constant(""))
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            TextField("Quantidade", text: .constant(""))
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Spacer()
        }
    }
}

struct ReceberView: View {
    var body: some View {
        VStack {
            Text("Receber Criptomoeda")
                .font(.title3)
                .padding()
            
            // Adicione aqui o conteúdo específico para receber
            Text("Seu endereço:")
                .font(.headline)
            
            Text("bc1qar0srrr7xfkvy5l643lydnw9re59gtzzwf5mdq")
                .font(.system(.body, design: .monospaced))
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)
            
            Spacer()
        }
    }
}

#Preview {
    teste()
}
