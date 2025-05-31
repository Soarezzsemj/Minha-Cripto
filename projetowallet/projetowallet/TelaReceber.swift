//
//  TelaReceber.swift
//  projetowallet
//
//  Created by Turma02-5 on 16/05/25.
//

import SwiftUI

struct TelaReceber: View {
    var body: some View {
        VStack{
        VStack {
            // Adicione aqui o conteúdo específico do QR Code
            Image(systemName: "qrcode")
                .font(.system(size: 180))
                .padding()
        }
            VStack{
                Text("bc1qar0srrr7xfkvy5l643lydnw9re59gtzzwf5mdq")
                    .font(.system(.body, design: .monospaced))
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
                
                Spacer()
            }
        }
    }
}
#Preview {
    TelaReceber()
}
