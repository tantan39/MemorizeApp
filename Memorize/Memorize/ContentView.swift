//
//  ContentView.swift
//  Memorize
//
//  Created by Tan Tan on 6/17/22.
//

import SwiftUI

struct ContentView: View {
    let cols = [GridItem(.adaptive(minimum: 85))]
    @StateObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        VStack {
            LazyVGrid(columns: cols) {
                ForEach(viewModel.cards, id: \.id) { card in
                    CardView(card: card)
                        .aspectRatio(2/3, contentMode: .fit)
                        .onTapGesture {
                            viewModel.choose(card)
                        }
                }
            }
            .foregroundColor(.red )
            Spacer()
        }
        .padding(.horizontal)
    }
}

struct CardView: View {
    let card: MemoryGame<String>.Card
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                let shape = RoundedRectangle(cornerRadius: 20)
                if card.isFaceUp {
                    shape.fill().foregroundColor(.white)
                    shape.strokeBorder(lineWidth: 3)
                    
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: .init())
            .preferredColorScheme(.dark)
//        ContentView(viewModel: .init())
//            .preferredColorScheme(.light)
    }
}
