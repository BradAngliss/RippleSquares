//
//  RippleSquare.swift
//  RippleSquares
//
//  Created by Brad Angliss on 19/01/2025.
//

import SwiftUI

struct RippleAnimationValues {
    var scale = 1.0
}

struct RippleSquare: View {
    var selectedPosition: Position
    var squareSize: CGFloat = 25
    var shouldAnimate: Bool = false
    var onTap: ((Position) -> Void)

    @State private var color: Color = .randomGreen

    var body: some View {
        Rectangle()
            .fill(color)
            .frame(width: squareSize, height: squareSize)
            .onTapGesture {
                onTap(selectedPosition)
            }
            .clipShape(RoundedRectangle(cornerRadius: 3))
            .keyframeAnimator(
                initialValue: RippleAnimationValues(),
                trigger: shouldAnimate,
                content: { view, value in
                    view
                        .scaleEffect(shouldAnimate ? value.scale : 1.0)
                },
                keyframes: { keyframes in
                    KeyframeTrack(\.scale) {
                        LinearKeyframe(0.8, duration: 0.3)
                        LinearKeyframe(1.1, duration: 0.2)
                        LinearKeyframe(1.0, duration: 0.3)
                    }
                })
    }
}

#Preview {
    @Previewable @State var animate: Bool = false

    VStack {
        RippleSquare(
            selectedPosition: .init(x: 0, y: 0),
            shouldAnimate: animate
        ) { _ in
            /* Implementation not required*/
        }

        Button("Animate") {
            animate.toggle()
        }
    }
}
