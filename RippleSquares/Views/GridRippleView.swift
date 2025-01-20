//
//  GridRippleView.swift
//  RippleSquares
//
//  Created by Brad Angliss on 19/01/2025.
//


import SwiftUI

typealias PositionDict = [Int: [Position]]

struct GridRippleView: View {
    let rows = 30
    let columns = 15
    let squareSize: CGFloat = 20
    let ringWidth: Double = 0.1
    
    @State private var animationStates: [[Bool]]
    
    init() {
        // Initialize animation states for the grid
        _animationStates = State(initialValue: Array(repeating: Array(repeating: false, count: columns), count: rows))
    }
    
    var body: some View {
        VStack(spacing: 5) {
            ForEach(0..<rows, id: \.self) { row in
                HStack(spacing: 5) {
                    ForEach(0..<columns, id: \.self) { column in
                        RippleSquare(
                            selectedPosition: .init(x: row, y: column),
                            squareSize: squareSize,
                            shouldAnimate: animationStates[row][column]) { position in
                            triggerRipple(from: position)
                        }
                        
                    }
                }
            }
        }
        .padding()
    }
    
    func triggerRipple(from tappedSquare: Position) {
        let distances = calculateDistances(from: tappedSquare)
        animateSquares(by: distances)
    }
    
    func calculateDistances(from tappedSquare: Position) -> PositionDict {
        var distanceMap: PositionDict = [:]
        for row in 0..<rows {
            for column in 0..<columns {
                let exactDistance = sqrt(pow(Double(row - tappedSquare.x), 2) + pow(Double(column - tappedSquare.y), 2))
                
                // Group distances into bands
                let bandedDistance = (exactDistance / ringWidth).rounded() * ringWidth
                distanceMap[Int(bandedDistance), default: []].append(.init(x: row, y: column))
            }
        }
        return distanceMap
    }
    
    func animateSquares(by distances: PositionDict) {
        let sortedDistances = distances.keys.sorted() // Ripple from closest to farthest
        
        for (index, distance) in sortedDistances.enumerated() {
            let squares = distances[distance] ?? []
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) * 0.1) { // Delay for ripple effect
                for square in squares {
                    animationStates[square.x][square.y] = true
                }
            }
            
            // Reset state after animation
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) * 0.1 + 0.8) {
                for square in squares {
                    animationStates[square.x][square.y] = false
                }
            }
        }
    }
}

#Preview {
    GridRippleView()
}
