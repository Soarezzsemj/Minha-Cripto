//
//  TelaListaTransacao.swift
//  projetowallet
//
//  Created by Turma02-5 on 15/05/25.
//

import SwiftUI

struct TelaListaTransacao: View {
    var body: some View {
        VStack{
            List{
                Text("ex1")
                Text("ex2")
                Text("ex3")
                Text("ex4")
                Text("ex5")
            }.navigationTitle("Últimas transações")
        }
    }
}
#Preview {
    TelaListaTransacao()
}
