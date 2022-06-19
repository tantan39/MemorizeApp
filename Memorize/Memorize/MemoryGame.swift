//
//  MemoryGame.swift
//  Memorize
//
//  Created by Tan Tan on 6/17/22.
//

import Foundation

struct MemoryGame<T> where T: Equatable {
    private(set) var cards: [Card]
    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get {
            let faceUpCardIndices = cards.indices.filter({ cards[$0].isFaceUp })
            return faceUpCardIndices.count == 1 ? faceUpCardIndices.first : nil
        }
        
        set {
            cards.indices.forEach({ cards[$0].isFaceUp = ($0 == newValue) })
        }
    }
    
    init(numberOfPairsOfCards: Int, createCardContentBy: ((Int) -> T)) {
        cards = []
        for i in 0..<numberOfPairsOfCards {
            let content = createCardContentBy(i)
            cards.append(Card(id: i*2, content: content))
            cards.append(Card(id: i*2 + 1, content: content))
        }
    }
    
    mutating func choose(_ card: Card) {
        if let index = cards.firstIndex(where: { $0.id == card.id }),
            !cards[index].isFaceUp,
            !cards[index].isMatched {
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                if cards[index].content == cards[potentialMatchIndex].content {
                    cards[index].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                }
                
                cards[index].isFaceUp = true
            } else {
                indexOfTheOneAndOnlyFaceUpCard = index
            }
        }
    }
        
    struct Card: Identifiable {
        let id: Int
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        let content: T
    }
}
