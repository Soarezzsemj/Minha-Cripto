//
//  Model.swift
//  projetowallet
//
//  Created by Turma02-5 on 15/05/25.
//

import Foundation

struct wallet : Decodable, Hashable {
    let _id : String?
    let _rev : String?
    let privateKey : String
    let publicKey : String?
    let address : address
    let status: String?
    let rfID : String?
}
struct address : Decodable, Hashable {
    let base58 : String
    let hex : String?
}


struct WalletInfoResponse: Decodable {
    let base58: String
    let balance: Double
}

struct TransferResponse: Decodable {
    let status: Bool
    let transaction: String
    let value: Int
}
