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
    
    mutating func choose(_ card: Card) {
        let index = cards.firstIndex(where: { $0.id == card.id }) ?? 0
        cards[index].isFaceUp.toggle()
    }
        
    struct Card: Identifiable {
        let id: Int
        var isFaceUp: Bool = false
        let isMatched: Bool = false
        let content: T
    }
}
