//
//  MemoryGame.swift
//  Memorize
//
//  Created by Tan Tan on 6/17/22.
//

import Foundation

struct MemoryGame<T> {
    private(set) var cards: [Card]
    
    init(numberOfPairsOfCards: Int, createCardContentBy: ((Int) -> T)) {
        cards = []
        for i in 0..<numberOfPairsOfCards {
            let content = createCardContentBy(i)
            cards.append(Card(id: i*2, content: content))
            cards.append(Card(id: i*2 + 1, content: content))
        }
    }
    
    func choose(_ card: Card) {
         
    }
        
    struct Card: Equatable {
        let id: Int
        let isFaceUp: Bool = false
        let isMatched: Bool = false
        let content: T
        
        static func == (lhs: MemoryGame<T>.Card, rhs: MemoryGame<T>.Card) -> Bool {
            lhs.id == rhs.id
        }
    }
}
