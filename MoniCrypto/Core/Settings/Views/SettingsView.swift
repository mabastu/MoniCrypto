//
//  SettingsView.swift
//  MoniCrypto
//
//  Created by Mabast on 24/08/2023.
//

import SwiftUI

struct SettingsView: View {
    
    let defaultURL = URL(string: "https://wwww.google.com")!
    let xURL = URL(string: "https://www.x.com/mabastu")!
    let coffeeURL = URL(string: "https://www.buymeacoffee.com/mabastu")!
    let coinGeckoURL = URL(string: "https://www.coingecko.com")!
    let personalURL = URL(string: "https://www.github.com/mabastu")!
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    VStack(alignment: .leading) {
                        Image("logo")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                        Text("This app was made by following @SwiftfulThinkingCourse on Youtube. It uses MVVM Architecture, Combine and CoreData!")
                            .font(.callout)
                            .fontWeight(.medium)
                            .foregroundColor(Color.theme.accent)
                    }
                    .padding(.vertical)
                    Link(destination: xURL, label: { Text("Follow Me on X 🧑🏻‍💻") })
                    Link(destination: coffeeURL, label: { Text("Support My Coffee Addiction ☕️") })
                } header: {
                    Text("Credits")
                }
                
                Section {
                    VStack(alignment: .leading) {
                        Image("coingecko")
                            .resizable()
                            .scaledToFit()
                            .frame( height: 100)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                        Text("The cryptocurrency data that used in this app comes from a free API from CoinGecko! prices my be slitly delayed.")
                            .font(.callout)
                            .fontWeight(.medium)
                            .foregroundColor(Color.theme.accent)
                    }
                    .padding(.vertical)
                    Link(destination: coinGeckoURL, label: { Text("Visit CoinGecko") })
                } header: {
                    Text("CoinGecko")
                }
                
                Section {
                    VStack(alignment: .leading) {
                        Image("mabast")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                        Text("This app developed by Mabast O. Hamadamin. It uses SwiftUI and written 100% in Swift. The project benefits from multi-threading, publishers/subscribers, and data percistance")
                            .font(.callout)
                            .fontWeight(.medium)
                            .foregroundColor(Color.theme.accent)
                    }
                    .padding(.vertical)
                    Link(destination: coinGeckoURL, label: { Text("Visit my Github profile 🤖") })
                } header: {
                    Text("Developer")
                }
            }
            .font(.headline)
            .accentColor(.blue)
            .listStyle(.grouped)
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    XMarkButton()
                }
            }
        }
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
