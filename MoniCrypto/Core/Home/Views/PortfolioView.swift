//
//  PortfolioView.swift
//  MoniCrypto
//
//  Created by Mabast on 25/07/2023.
//

import SwiftUI

struct PortfolioView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    @State private var selectedCoin: Coin? = nil
    @State private var quantity: String = ""
    @State private var showCheckmark: Bool = false
    
    private func getCurrentValue() -> Double {
        if let quantity = Double(quantity) {
            return quantity * (selectedCoin?.currentPrice ?? 0)
        }
        return 0
    }
    
    private func saveButtonPressed() {
        guard let coin = selectedCoin else { return }
        
        // Save to Portfolio
        
        
        // Show Chcckmark
        withAnimation(.easeIn) {
            showCheckmark = true
            removeSelectedCoin()
        }
        
        // Dismiss Keyboard
        UIApplication.shared.endEditing()
        
        // Hide Checkmark
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation(.easeOut) {
                showCheckmark = false
            }
        }
    }
    
    func removeSelectedCoin() {
        selectedCoin = nil
        vm.searchText = ""
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    
                    // Search Bar
                    SearchBarView(searchText: $vm.searchText)
                    
                    // Coin ScrollView
                    ScrollView(.horizontal, showsIndicators: false, content:{
                        LazyHStack(spacing: 10) {
                            ForEach(vm.allCoins) { coin in
                                CoinLogoView(coin: coin)
                                    .frame(width: 75)
                                    .padding(4)
                                    .onTapGesture {
                                        withAnimation(.easeIn) {
                                            selectedCoin = coin
                                        }
                                    }
                                    .background(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(selectedCoin?.id == coin.id ? Color.theme.green : Color.clear, lineWidth: 1)
                                    )
                                
                            }
                        }
                        .frame(height: 120)
                        .padding(.leading)
                    })
                    
                    // Portfolio Input Section
                    
                    if selectedCoin != nil {
                        VStack(spacing: 20) {
                            HStack {
                                Text("Current Price of \(selectedCoin?.symbol.uppercased() ?? ""):")
                                Spacer()
                                Text(selectedCoin?.currentPrice.asCurrencyWith6Decimals() ?? "")
                            }
                            Divider()
                            HStack {
                                Text("Amount Holding:")
                                Spacer()
                                TextField("Ex: 1.4", text: $quantity)
                                    .multilineTextAlignment(.trailing)
                                    .keyboardType(.decimalPad)
                            }
                            Divider()
                            HStack {
                                Text("Current Value:")
                                Spacer()
                                Text(getCurrentValue().asCurrencyWith2Decimals())
                            }
                        }
                        .animation(nil, value: UUID())
                        .padding()
                        .font(.headline)
                        
                    }
                }
            }
            .navigationTitle("Edit Portfolio")
            .toolbar(content: {
                ToolbarItem(placement: .topBarLeading) {
                    XMarkButton()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack(spacing: 10) {
                        Image(systemName: "checkmark")
                            .opacity(showCheckmark ? 1.0 : 0.0)
                        Button {
                            saveButtonPressed()
                        } label: {
                            Text("Save".uppercased())
                        }
                        .opacity(selectedCoin != nil && selectedCoin?.currentHoldings != Double(quantity) ? 1.0 : 0.0)

                    }
                }
            })
        }
    }
}



struct PortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioView()
            .environmentObject(dev.homeVM)
    }
}
