//
//  MarketDataService.swift
//  MoniCrypto
//
//  Created by Mabast on 17/07/2023.
//

import Foundation
import Combine

class MarketDataService: ObservableObject {
    
    @Published var marketData: MarketData? = nil
    var marketDataSubscription: AnyCancellable?
    
    init() {
        getData()
    }
    
    func getData() {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/global") else { return }
        
        marketDataSubscription = NetworkingManager.download(url: url)
            .decode(type: GlobalData.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] returnedGlobalData in
                self?.marketData = returnedGlobalData.data
                self?.marketDataSubscription?.cancel()
            })
    }
}
