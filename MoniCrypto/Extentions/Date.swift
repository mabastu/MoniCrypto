//
//  Date.swift
//  MoniCrypto
//
//  Created by Mabast on 21/08/2023.
//

import Foundation

extension Date {
    
    //"2021-03-13T20:49:26.606Z"
    init(coinString: String) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'Hh:mm:ss.SSSZ"
        let date = formatter.date(from: coinString) ?? Date()
        self.init(timeInterval: 0, since: date)
    }
    
    private var shortFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }
    
    func asShortDateString() -> String {
        return shortFormatter.string(from: self)
    }
}
