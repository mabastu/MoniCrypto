//
//  Color.swift
//  MoniCrypto
//
//  Created by Mabast on 19/06/2023.
//

import Foundation
import SwiftUI

extension Color {
    
    static let theme = ColorTheme()
    
}

struct ColorTheme {
    let accent = Color("AccentColor")
    let background = Color("BackgroundColor")
    let green = Color("GreenColor")
    let red = Color("RedColor")
    let secondaryText = Color("SecondaryTextColor")
    let launchBackgroundColor = Color("LaunchBackgroundColor")
    let launchAccentColor = Color("LaunchAccentColor")
}
