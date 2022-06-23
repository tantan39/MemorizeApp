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
    @State private var dealt = Set<Int>()
    
    var body: some View {
        VStack {
            gameView
            Button("Shuffle") {
                withAnimation {
                    viewModel.shuffle()
                }
            }
        }
        .padding()
    }
    
    var gameView: some View {
        AspectVGrid(items: viewModel.cards, aspectRatio: 2/3) { card in
            cardView(for: card)
        }
        .onAppear(perform: {
            withAnimation {
                for card in viewModel.cards {
                    dealt(card)
                }
            }
        })
        .foregroundColor(.red )
    }
    
    @ViewBuilder
    private func cardView(for card: EmojiMemoryGame.Card) -> some View {
        if unDealt(card) || (card.isMatched && !card.isFaceUp) {
            Rectangle().opacity(0)
        } else {
            CardView(card: card)
                .padding(4)
                .transition(AnyTransition.asymmetric(insertion: .scale, removal: .opacity))
                .onTapGesture {
                    withAnimation {
                        viewModel.choose(card)
                    }
                }
        }
    }
    
    private func dealt(_ card: EmojiMemoryGame.Card) {
        dealt.insert(card.id)
    }
    
    private func unDealt(_ card: EmojiMemoryGame.Card) -> Bool {
        !dealt.contains(card.id)
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
