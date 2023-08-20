//
//  DetailViewModel.swift
//  MoniCrypto
//
//  Created by Mabast on 20/08/2023.
//

import Foundation
import Combine

class DetailViewModel: ObservableObject {
    
    private let coinDetailService: CoinDetailDataService
    private var cancellables = Set<AnyCancellable>()
    
    init(coin: Coin) {
        self.coinDetailService = CoinDetailDataService(coin: coin)
        self.addSubscribers()
    }
    
    private func addSubscribers() {
        coinDetailService.$coinDetails.sink { returnedDetails in
            print("Returned Detail")
        }.store(in: &cancellables)
    }
    
}
