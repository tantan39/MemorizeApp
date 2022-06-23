//
//  Cardify.swift
//  Memorize
//
//  Created by Tan Tan on 6/21/22.
//

import SwiftUI

struct Cardify: ViewModifier, Animatable  {
    var rotation: Double
    
    var animatableData: Double {
        get { rotation }
        set {
            rotation = newValue
        }
    }
    
    init(isFaceUp: Bool) {
        rotation = isFaceUp ? 0 : 180
    }
    
    func body(content: Content) -> some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            if rotation < 90 {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
            } else {
                shape.fill()
            }
            content.opacity(rotation < 90 ? 1 : 0)
        }
        .rotation3DEffect(.degrees(rotation), axis: (0,1,0))
    }
}

extension View {
    func cardify(_ isFaceUp: Bool) -> some View  {
        return self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}
