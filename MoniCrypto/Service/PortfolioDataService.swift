//
//  PortfloioDataService.swift
//  MoniCrypto
//
//  Created by Mabast on 15/08/2023.
//

import Foundation
import CoreData

class PortfolioDataService {
    
    private let container: NSPersistentContainer
    private let containerName: String = "PortfolioContainer"
    private let entityName: String = "Portfolio"
    
    @Published var savedEntites: [Portfolio] = []
    
    init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { _, error in
            if let error = error {
                print("Error loading CoreData. \(error)")
            }
            self.getPortfolio()
        }
    }
    
    func updatePortfolio(coin: Coin, amount: Double) {
        if let entity = savedEntites.first(where: { $0.coinId == coin.id }) {
            if amount > 0 {
                update(entity: entity, amount: amount)
            } else {
                delete(entity: entity)
            }
        } else {
            add(coin: coin, amount: amount)
        }
    }
    
    private func getPortfolio() {
        let request = NSFetchRequest<Portfolio>(entityName: entityName)
        
        do {
            savedEntites = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching Portfolio Entity. \(error)")
        }
    }
    
    private func add(coin: Coin, amount: Double) {
        let entity = Portfolio(context: container.viewContext)
        entity.coinId = coin.id
        entity.amount = amount
        applyChanges()
    }
    
    private func update(entity: Portfolio, amount: Double) {
        entity.amount = amount
        applyChanges()
    }
    
    private func delete(entity: Portfolio) {
        container.viewContext.delete(entity)
        applyChanges()
    }
    
    private func save() {
        do {
            try container.viewContext.save()
        } catch let error {
            print("Error saving to CoreData \(error)")
        }
    }
    
    private func applyChanges() {
        save()
        getPortfolio()
    }
    
}
