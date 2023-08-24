//
//  String.swift
//  MoniCrypto
//
//  Created by Mabast on 24/08/2023.
//

import Foundation

extension String {
    
    var removingHTMLOccurances: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression)
    }
    
}
