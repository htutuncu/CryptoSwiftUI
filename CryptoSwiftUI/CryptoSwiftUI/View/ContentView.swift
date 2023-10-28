//
//  ContentView.swift
//  CryptoSwiftUI
//
//  Created by Hikmet Tütüncü on 27.10.2023.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var cryptoListViewModel : CryptoListViewModel
    
    init() {
        self.cryptoListViewModel = CryptoListViewModel()
    }
    
    var body: some View {
        NavigationStack {
            List(cryptoListViewModel.cryptoList, id: \.id) { crypto in
                VStack {
                    Text(crypto.currency)
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        .foregroundStyle(.blue)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text(crypto.price)
                        .font(.title)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                
            }.navigationTitle("Crypto Swift UI")
        }.task {
            await cryptoListViewModel.fetchDataAsync(url: URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json")!)
        }
    }
}

#Preview {
    ContentView()
}
