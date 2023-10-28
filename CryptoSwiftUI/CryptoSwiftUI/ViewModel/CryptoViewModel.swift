//
//  CryptoViewModel.swift
//  CryptoSwiftUI
//
//  Created by Hikmet Tütüncü on 27.10.2023.
//

import Foundation

class CryptoListViewModel : ObservableObject {
    
    @Published var cryptoList = [CryptoViewModel]()
    @Published var errorMessage = ""
    
    let webService = Webservice()
    
    
    func fetchDataAsync(url: URL) async  {
        do {
            let cryptoList = try await webService.downloadCurrenciesAsync(url: url)
            DispatchQueue.main.async {
                self.cryptoList = cryptoList.map(CryptoViewModel.init)
            }
        } catch {
            print("Error")
        }
        
    }
    
    func fetchData(url: URL) {
        webService.downloadCurrencies(url: url) { result in
        switch result {
        case .success(let cryptoList):
            DispatchQueue.main.async {
                self.cryptoList = cryptoList.map(CryptoViewModel.init)
            }
            
            
        case .failure(let error):
            switch error {
                case .urlError:
                    print(error)
                case .decodingError:
                    print(error)
                case .serverError:
                    print(error)
                }
        }
        }
    }
}

struct CryptoViewModel {
    
    let crypto : Crypto
    
    var id : UUID? {
        crypto.id
    }
    
    var price : String {
        crypto.price
    }
    
    var currency : String {
        crypto.currency
    }
}
