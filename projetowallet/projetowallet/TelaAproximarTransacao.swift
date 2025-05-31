//import SwiftUI
//
//struct TelaAproximarTransacao: View {
//    var body: some View {
//        NavigationStack{
//        
//            VStack{
//                
//                VStack{
//                    
//                    VStack{
//                        Text("Aproxime seu cartão RFID")
//                            .font(.title2)
//                            .bold()
//                           
//                    }
//                   
//                    VStack{
//                        
//                        Text("Aproxime seu cartão de aproximação para confirmar a transação, enchecao de linguica pra ficar bem legal.")
//                            .multilineTextAlignment(.center)
//                            .font(.body)
//                            .foregroundColor(.gray)
//                
//                        
//                    }.padding(5)
//                    
//                }
//                .padding([.top], 30)
//                .padding([.leading, .trailing, .bottom])
//                
//                Spacer()
//
//              
//                VStack{
//                    Image(systemName: "wave.3.right.circle.fill")
//                        .font(.system(size: 150))
//                        .foregroundColor(Color("AZUL_CLARO"))
//                    
//                    
//                    
//                }
//                .padding([.bottom], 50)
//
//                
//                Spacer()
//
//                
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
//        }
//    }
//}
//#Preview {
//    TelaAproximarTransacao()
//}
//
