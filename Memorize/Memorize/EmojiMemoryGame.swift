//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Tan Tan on 6/17/22.
//

import Foundation


class EmojiMemoryGame: ObservableObject {
    typealias Card = MemoryGame<String>.Card
    static let emojis = ["🛫", "🚘", "🚒", "🚑", "🚕", "🚜", "🚌", "🚁", "🚲", "🏍", "🏎"]
    
    static func createCardModels() -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: 10) { index in
            return emojis[index]
        }
    }
    
    @Published private var model = createCardModels()
    
    var cards: [Card] {
        return model.cards
    }
    
    func choose(_ card: Card) {
        model.choose(card )
    }
    
}
