//import SwiftUI
//
//struct TelaEnviar: View {
//    
//    @StateObject var api = APIView()
//
//    @State private var destinatario = "TSwV3qWeRdoKLjKaYthg6Cmn5n5Kew2tYW"
//    @State private var valorTexto = ""
//    
//    // Converte o valorTexto em Double, se possível
//    var valorConvertido: Double? {
//        Double(valorTexto.replacingOccurrences(of: ",", with: ".")) // suporta vírgulas
//    }
//    
//    // Validação: destinatário preenchido e valor numérico > 0
//    var camposValidos: Bool {
//        !destinatario.trimmingCharacters(in: .whitespaces).isEmpty && (valorConvertido ?? 0) > 0
//    }
//    
//    
//    var body: some View {
//        VStack(spacing: 20) {
//            Spacer()
//            
//            VStack(alignment: .leading, spacing: 8) {
//                Text("Para:")
//                    .foregroundColor(.black)
//                    .padding(.leading, 5)
//                
//                TextField("", text: $destinatario)
//                    .padding()
//                    .frame(width: 300, height: 40)
//                    .background(Color(.systemGray6))
//                    .cornerRadius(8)
//                    .multilineTextAlignment(.leading)
//            }
//            
//            VStack(alignment: .leading, spacing: 8) {
//                Text("Valor:")
//                    .foregroundColor(.black)
//                    .padding(.leading, 5)
//                
//                TextField("", text: $valorTexto)
//                    .keyboardType(.decimalPad)
//                    .padding()
//                    .frame(width: 300, height: 40)
//                    .background(Color(.systemGray6))
//                    .cornerRadius(8)
//                    .multilineTextAlignment(.leading)
//            }
//            
//            Spacer()
//            
//            VStack {
//                Button("Enviar") {
//                    if let valor = valorConvertido {
//                        api.transferir(destinatario: destinatario, valor: valor, privateKey: "8810093C287C1D5286904E80CDAB98C8A43AA69383AA781A55E13F7091A1B8CB")
//                        // Limpa os campos se quiser
//                        destinatario = ""
//                        valorTexto = ""
//                    }
//                }
//                .disabled(!camposValidos)
//                .padding([.leading, .trailing], 70)
//                .padding([.top, .bottom], 15)
//                .foregroundColor(.white)
//                .background(camposValidos ? Color("AZUL_CLARO") : Color.gray)
//                .cornerRadius(10)
//                
//                Spacer()
//            }
//        }
//    }
//}
//#Preview {
//    TelaEnviar()
//}
//
