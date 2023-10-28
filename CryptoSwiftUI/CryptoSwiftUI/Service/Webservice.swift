//
//  Webservice.swift
//  CryptoSwiftUI
//
//  Created by Hikmet Tütüncü on 27.10.2023.
//

import Foundation

enum CryptoError : Error {
    case serverError
    case decodingError
    case urlError
}

class Webservice {
    
    
    func downloadCurrenciesAsync(url: URL) async throws -> [Crypto] {
        let (data, _) = try await URLSession.shared.data(from: url)
        let currencyList = try? JSONDecoder().decode([Crypto].self, from: data)
        return currencyList ?? []
    }
    
    
    func downloadCurrencies(url: URL, completion: @escaping (Result<[Crypto],CryptoError>)->()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error {
                completion(.failure(.serverError))
            } else if let data = data {
                
                let cryptoList = try? JSONDecoder().decode([Crypto].self, from: data)
                
                if let cryptoList = cryptoList {
                    completion(.success(cryptoList))
                } else {
                    completion(.failure(.decodingError))
                }
            }
        }.resume()
    }
}
