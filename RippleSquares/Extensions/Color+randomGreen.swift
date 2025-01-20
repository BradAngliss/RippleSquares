//
//  Color+randomGreen.swift
//  RippleSquares
//
//  Created by Brad Angliss on 19/01/2025.
//

import SwiftUI

extension Color {
    static var randomGreen: Color {
        Color(
            red: Double.random(in: 0.0...0.4),
            green: Double.random(in: 0.5...1.0),
            blue: Double.random(in: 0.0...0.4)
        )
    }
}
