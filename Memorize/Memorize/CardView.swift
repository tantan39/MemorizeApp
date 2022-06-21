//
//  CardView.swift
//  Memorize
//
//  Created by Tan Tan on 6/20/22.
//

import SwiftUI

struct CardView: View {
    let card: MemoryGame<String>.Card
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                let shape = RoundedRectangle(cornerRadius: 20)
                if card.isFaceUp {
                    shape.fill().foregroundColor(.white)
                    shape.strokeBorder(lineWidth: 3)
                    Circle()
                    Text(card.content)
                        .font(Font.system(size: min(geometry.size.width, geometry.size.height) * 0.7))
                } else if card.isMatched {
                    shape.opacity(0)
                } else {
                    shape.fill().foregroundColor(.red)
                }
                
            }
        }
    }
}
