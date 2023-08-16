//
//  HomeView.swift
//  MoniCrypto
//
//  Created by Mabast on 19/06/2023.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    @State private var showPortfolio: Bool = false
    @State private var showPortfolioView: Bool = false
    
    var body: some View {
        ZStack {
            
            // Backgound Layer
            Color.theme.background
                .ignoresSafeArea()
                .sheet(isPresented: $showPortfolioView, content: {
                    PortfolioView()
                        .environmentObject(vm)
                })
            
            // Content Layer
            VStack {
                // Home Header
                HStack {
                    CircleButtonView(iconName: showPortfolio ? "plus" : "info")
                        .animation(.none, value: showPortfolio)
                        .onTapGesture {
                            if showPortfolio {
                                showPortfolioView.toggle()
                            }
                        }
                        .background(CircleButtonAnimationView(animate: $showPortfolio))
                    Spacer()
                    Text(showPortfolio ? "Portfolio" : "Live Prices")
                        .font(.headline)
                        .fontWeight(.heavy)
                        .foregroundColor(Color.theme.accent)
                        .animation(.none)
                    Spacer()
                    CircleButtonView(iconName: "chevron.right")
                        .rotationEffect(Angle(degrees: showPortfolio ? 180 : 0))
                        .onTapGesture {
                            withAnimation(.spring()) {
                                showPortfolio.toggle()
                            }
                        }
                }
                .padding(.horizontal)
                
                // Home Statistics View
                HomeStatsView(showPortfolio: $showPortfolio)
                
                // Search Bar
                SearchBarView(searchText: $vm.searchText)
                
                // Column Titles
                HStack {
                    Text("Coins")
                    Spacer()
                    if showPortfolio {
                        Text("Holdings")
                    }
                    Text("Price")
                        .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
                    Button {
                        withAnimation(.linear(duration: 2.0)) {
                            vm.reloadData()
                        }
                    } label: {
                        Image(systemName: "goforward")
                    }

                }
                .padding(.horizontal)
                .font(.caption)
                .foregroundColor(Color.theme.secondaryText)
                
                
                if !showPortfolio {
                    // All Coins ListView
                    List {
                        ForEach(vm.allCoins) { coin in
                            CoinRowView(coin: coin, showHoldingsColumn: false)
                                .listRowInsets(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 10))
                        }
                    }
                    .refreshable {
                        vm.reloadData()
                    }
                    .listStyle(PlainListStyle())
                    .transition(.move(edge: .leading))
                } else {
                    // Portfolio Coins ListView
                    List {
                        ForEach(vm.portfolioCoins) { coin in
                            CoinRowView(coin: coin, showHoldingsColumn: true)
                                .listRowInsets(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 10))
                        }
                    }
                    .listStyle(PlainListStyle())
                    .transition(.move(edge: .trailing))
                }
                Spacer(minLength: 0)
            }
            
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeView()
                .navigationBarHidden(true)
        }
        .environmentObject(dev.homeVM)
    }
}
