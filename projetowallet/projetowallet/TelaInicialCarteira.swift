//
//  TelaInicialCarteira.swift
//  projetowallet
//
//  Created by Turma02-5 on 14/05/25.
//

import SwiftUI

struct TelaInicialCarteira: View {
    @State private var destinatario = ""
    @State private var valor: Double = 0
    @State var showSheet = false
    @State private var selectedTab = 0 // Controla qual botão está selecionado
    var body: some View {
        NavigationStack{
            ZStack {
               
            }
        }
        .onAppear {
            showSheet = true
        }
        .sheet(isPresented: $showSheet) {
            VStack(spacing: 0) {
                // PARTE SUPERIOR FIXA (ícones)
                VStack(spacing: 10) {

                    
                    HStack(spacing: 30) {
                        // Botão 1 - enviar
                        Spacer()

                        Button(action: {
                            selectedTab = 0
                        }) {
                            VStack {
                                Image(systemName: "square.and.arrow.up")
                                    .font(.system(size: 24))
                                    .padding(15)
                                    .background(selectedTab == 0 ? Color.AZUL_CLARO.opacity(0.2) : Color.gray.opacity(0.1))
                                    .clipShape(Circle())
                                Text("Enviar")
                                    .font(.caption)
                            }
                        }
                        .foregroundColor(selectedTab == 0 ? .AZUL_CLARO : .gray)
                        Spacer()
                        // Botão 2 - receber
                        Button(action: {
                            selectedTab = 1
                        }) {
                            VStack {
                                Image(systemName: "square.and.arrow.down")
                                    .font(.system(size: 24))
                                    .padding(15)
                                    .background(selectedTab == 1 ? Color.AZUL_CLARO.opacity(0.2) : Color.gray.opacity(0.1))
                                    .clipShape(Circle())
                                Text("Receber")
                                    .font(.caption)
                            }
                        }
                        .foregroundColor(selectedTab == 1 ? .AZUL_CLARO : .gray)
                        
                        Spacer()

                        // Botão 3 - transacoes
                        Button(action: {
                            selectedTab = 2
                        }) {
                            VStack {
                                Image(systemName: "list.bullet")
                                    .font(.system(size: 24))
                                    .padding(15)
                                    .background(selectedTab == 2 ? Color.AZUL_CLARO.opacity(0.2) : Color.gray.opacity(0.1))
                                    .clipShape(Circle())
                                Text("Transações")
                                    .font(.caption)
                            }
                        }
                        .foregroundColor(selectedTab == 2 ? .AZUL_CLARO : .gray)
                        Spacer()

                    }
                    .padding(.vertical)
                }
                .padding()
                
                Divider()
                
                // PARTE INFERIOR DINÂMICA (conteúdo que muda)
//                Group {
//                    switch selectedTab {
//                    case 0:
//                        TelaEnviar()
//                    case 1:
//                        TelaReceber()
//                    case 2:
//                        TelaListaTransacao()
//                    default:
//                        EmptyView()
//                    }
//                }
//                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .presentationDetents([.medium])
            .presentationDragIndicator(.hidden)
            .interactiveDismissDisabled(true)
        }
    }
}
#Preview {
    TelaInicialCarteira()
}
