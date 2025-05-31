import SwiftUI

struct TelaConfirmTransacao: View {
    var body: some View {
        VStack{
            VStack(){
                Text("Transação Confirmada!")
                    .multilineTextAlignment(.center)
                    .frame(alignment: .center)
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .bold()
                   
            }
            VStack{
                
                Text("Sua transação foi registrada com sucesso na blockchain.")
                    .multilineTextAlignment(.center)
                    .frame(alignment: .center)
                
                    
            }
           
            Spacer()
            VStack{
                Image(systemName: "checkmark.circle.fill")
                    .font(.system(size: 150))
                    .foregroundColor(Color(.green))
            }
            Spacer()
          
            VStack{
                NavigationLink(destination: TelaInicialCarteira()){
                        Text("Confirmar")
                        .foregroundColor(.black)
                        .bold()
                        .frame(width: 210, height: 50)
                        .overlay(
                        RoundedRectangle(cornerRadius: 10)
                        .stroke(.black,lineWidth: 1))
                        .navigationBarBackButtonHidden(true)
                        
                        
    //                        .padding([.leading,.trailing],70)
    //                        .padding([.top,.bottom],15)
    //                        .foregroundColor(.white)
    //                        .background(Color("AZUL_CLARO"))
    //                        .cornerRadius(10)
                            
                    }
            }
            VStack{
            NavigationLink(destination: TelaListaTransacao()){
                Text("Ver Transação")
                    .bold()
                    .frame(width: 210, height: 50)
                    .foregroundColor(.white)
                    .background(Color("AZUL_CLARO"))
                    .cornerRadius(10)
                    .navigationBarBackButtonHidden(true)
            
            }
        }
       
  
      }

    }
}
#Preview {
    TelaConfirmTransacao()
}

