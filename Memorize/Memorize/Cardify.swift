//
//  Cardify.swift
//  Memorize
//
//  Created by Tan Tan on 6/21/22.
//

import SwiftUI

struct Cardify: ViewModifier {
    var isFaceUp: Bool
    
    func body(content: Content) -> some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            if isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
            } else {
                shape.fill()
            }
            content.opacity(isFaceUp ? 1 : 0)
        }
    }
}

extension View {
    func cardify(_ isFaceUp: Bool) -> some View  {
        return self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}
