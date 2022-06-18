//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Tan Tan on 6/17/22.
//

import Foundation


class EmojiMemoryGame {
    static let emojis = ["🛫", "🚘", "🚒", "🚑", "🚕", "🚜", "🚌", "🚁", "🚲", "🏍", "🏎"]
    
    static func createCardModels() -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: 10) { index in
            return emojis[index]
        }
    }
    
    private var model = createCardModels()
    
    var cards: [MemoryGame<String>.Card] {
        return model.cards
    }
    
    
}
