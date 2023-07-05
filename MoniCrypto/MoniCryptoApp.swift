//
//  MoniCryptoApp.swift
//  MoniCrypto
//
//  Created by Mabast on 19/06/2023.
//

import SwiftUI

@main
struct MoniCryptoApp: App {
    
    @StateObject private var vm = HomeViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView()
                    .navigationBarHidden(true)
            }
            .environmentObject(vm)
        }
    }
}
