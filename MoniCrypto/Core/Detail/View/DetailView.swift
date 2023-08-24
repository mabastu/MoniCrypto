//
//  DetailView.swift
//  MoniCrypto
//
//  Created by Mabast on 18/08/2023.
//

import SwiftUI

struct DetailLoadingView: View {
    
    @Binding var coin: Coin?
    
    var body: some View {
        ZStack {
            if let coin = coin {
                DetailView(coin: coin)
            }
        }
    }
}

struct DetailView: View {
    
    @StateObject private var vm: DetailViewModel
    @State private var showFullDescription: Bool = false
    private let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    init(coin: Coin) {
        _vm = StateObject(wrappedValue: DetailViewModel(coin: coin))
    }
     
    var body: some View {
        ScrollView {
            VStack {
                ChartView(coin: vm.coin)
                VStack(spacing: 20) {
                    Text("Overview")
                        .font(.title)
                        .bold()
                        .foregroundColor(Color.theme.accent)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Divider()
                    
                    ZStack {
                        if let coinDescription = vm.coinDescription, !coinDescription.isEmpty {
                            VStack(alignment: .leading) {
                                Text(coinDescription)
                                    .lineLimit(showFullDescription ? nil : 3)
                                    .font(.callout)
                                    .foregroundColor(Color.theme.secondaryText)
                                Button(action: {
                                    withAnimation(.easeInOut) {
                                        showFullDescription.toggle()
                                    }
                                }, label: {
                                    Text(showFullDescription ? "Less" : "Read More..")
                                        .font(.caption)
                                        .fontWeight(.bold)
                                        .padding(.vertical, 2)
                                })
                                .accentColor(.blue)
                            }
                        }
                    }
                    
                    LazyVGrid(columns: columns, alignment: .leading, spacing: 30, pinnedViews: [], content: {
                        ForEach(vm.overviewStatistics) { stat in
                            StatisticView(stat: stat)
                        }
                    })
                    
                    Text("Additional Details")
                        .font(.title)
                        .bold()
                        .foregroundColor(Color.theme.accent)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Divider()
                    
                    LazyVGrid(columns: columns, alignment: .leading, spacing: 30, pinnedViews: [], content: {
                        ForEach(vm.additionalStatistics) { stat in
                            StatisticView(stat: stat)
                        }
                    })
                    VStack(alignment: .leading, spacing: 20) {
                        if let websiteURLString = vm.websiteURL, let url = URL(string: websiteURLString) {
                            Link("Website", destination: url)
                        }
                        if let redditURLString = vm.redditURL, let url = URL(string: redditURLString) {
                            Link("Reddit", destination: url)
                        }
                    }
                    .accentColor(.blue)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.headline)
                }
                .padding()
            }
        }
        .navigationTitle(vm.coin.name)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                HStack {
                    Text(vm.coin.symbol.uppercased())
                        .font(.headline)
                    .foregroundColor(Color.theme.accent)
                    CoinImageView(coin: vm.coin)
                        .frame(width: 25, height: 25)
                }
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailView(coin: dev.coin)
        }
    }
}
