//
//  Crypto.swift
//  CryptoSwiftUI
//
//  Created by Hikmet Tütüncü on 27.10.2023.
//

import Foundation

struct Crypto : Decodable, Identifiable {
    let id = UUID()
    let currency : String
    let price : String
}
