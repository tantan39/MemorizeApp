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
    @Namespace private var dealCardNameSpace
    
    var body: some View {
        VStack {
            gameView
            deckBody
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
        .foregroundColor(.red )
    }
    
    var deckBody: some View {
        ZStack {
            ForEach(viewModel.cards.filter(unDealt)) { card in
                CardView(card: card)
                    .matchedGeometryEffect(id: card.id, in: dealCardNameSpace)
                    .transition(AnyTransition.asymmetric(insertion: .opacity, removal: .identity))
                    .zIndex(zIndex(for: card))
            }
        }
        .foregroundColor(.red)
        .frame(width: CardConstants.unDealWidth, height: CardConstants.unDealHeight)
        .onTapGesture {
            for card in viewModel.cards {
                withAnimation(dealAnimation(for: card)) {
                    dealt(card)
                }
            }
        }
    }
    
    @ViewBuilder
    private func cardView(for card: EmojiMemoryGame.Card) -> some View {
        if unDealt(card) || (card.isMatched && !card.isFaceUp) {
            Rectangle().opacity(0)
        } else {
            CardView(card: card)
                .padding(4)
                .matchedGeometryEffect(id: card.id, in: dealCardNameSpace)
                .transition(AnyTransition.asymmetric(insertion: .identity, removal: .scale))
                .zIndex(zIndex(for: card))
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
    
    private func dealAnimation(for card: EmojiMemoryGame.Card) -> Animation {
        var delay = 0.0
        if let index = viewModel.cards.firstIndex(where: { $0.id == card.id }) {
            delay = Double(index) * (2 / Double(viewModel.cards.count))
        }
        return Animation.easeInOut(duration: 1).delay(delay)
    }
    
    private func zIndex(for card: EmojiMemoryGame.Card) -> Double {
        -Double(viewModel.cards.firstIndex(where: { $0.id == card.id}) ?? 0)
    }
    
    struct CardConstants {
        static var unDealHeight = 90.0
        static var unDealWidth = unDealHeight * 2/3
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
