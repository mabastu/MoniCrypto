//
//  HomeView.swift
//  MoniCrypto
//
//  Created by Mabast on 19/06/2023.
//

import SwiftUI

struct HomeView: View {
    
    
    
    var body: some View {
        ZStack {
            
            // Backgound Color
            Color.theme.background
                .ignoresSafeArea()
            
            // Content Layer
            VStack {
                HStack {
                    CircleButtonView(iconName: "info")
                    Spacer()
                    Text("Header")
                        .font(.headline)
                        .fontWeight(.heavy)
                        .foregroundColor(Color.theme.accent)
                    Spacer()
                    CircleButtonView(iconName: "chevron.right")
                }
                .padding(.horizontal)
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
    }
}
