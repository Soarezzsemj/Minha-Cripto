//
//  TelaSalvarKey.swift
//  projetowallet
//
//  Created by Turma02-5 on 13/05/25.
//

//import SwiftUI
//
//struct TelaSalvarKey: View {
//    
//    @StateObject var api = APIView()
//    
//    var body: some View {
//        NavigationStack{
//            VStack{
//                VStack{
//                    Text("LORENY")
//                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
//                        .bold()
//                }
//                VStack{
//                    Text("Aproxime seu cartão de aproximação")
//                    Text("para salvar sua chave")
//                }
//                Spacer()
//                VStack{
//                    Image(systemName: "wave.3.right.circle.fill")
//                        .font(.system(size: 150))
//                        .foregroundColor(Color("AZUL_CLARO"))
//                    Text(api.wallet.publicKey!)
//                    Text(api.wallet.privateKey!)
//                    Text(api.wallet._id!)
//                    Text(api.wallet._rev!)
//                }
//                Spacer()
//                VStack{
//                    NavigationLink(destination: TelaConfirmSalvar()){
//                        Text("Confirmar")
//                            .padding([.leading,.trailing],70)
//                            .padding([.top,.bottom],15)
//                            .foregroundColor(.white)
//                            .background(Color("AZUL_CLARO"))
//                            .cornerRadius(10)
//                    }
//                }
//            }
//        }.onAppear(){
//            //api.criarWallet()
//        }
//        
//    }
//}
//#Preview {
//    TelaSalvarKey()
//}
