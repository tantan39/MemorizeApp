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
                Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: 110-90))
                    .padding(5).opacity(0.5)
                Text(card.content)
                    .font(Font.system(size: min(geometry.size.width, geometry.size.height) * 0.7))
                
            }
            .modifier(Cardify(isFaceUp: card.isFaceUp))
        }
    }
}
