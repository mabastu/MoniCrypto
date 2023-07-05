//
//  UIApplication.swift
//  MoniCrypto
//
//  Created by Mabast on 05/07/2023.
//

import Foundation
import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
