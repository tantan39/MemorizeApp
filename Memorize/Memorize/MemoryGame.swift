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
        cards.shuffle()
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
    
    mutating func shuffle() {
        cards.shuffle()
    }
        
    struct Card: Identifiable {
        let id: Int
        var isFaceUp: Bool = false {
            didSet {
                if isFaceUp {
                    startUsingBonusTime()
                } else {
                    stopUsingBonusTime()
                }
            }
        }
        
        var isMatched: Bool = false {
            didSet {
                stopUsingBonusTime()
            }
        }
        
        let content: T
        
        // MARK: - Bonus Time
        
        // this could give matching bonus points
        // if the user match the cards
        // before a certain amount of time passes during which the card is face up
        
        // can be zero which means "no bonus available" for this card
        var bonusTimeLimit: TimeInterval = 6
        
        // how long this card has ever been face up
        var faceUpTime: TimeInterval {
            if let faceUpDate = self.lastFaceUpDate {
                return pastFaceUpTime + Date().timeIntervalSince(faceUpDate)
            } else {
                return self.pastFaceUpTime
            }
        }
        
        // the last time this card was turned face up (and is still face up)
        var lastFaceUpDate: Date?
        // the accumulated time this card has been face up in the past
        // (i.e not including the current time it's been face up if it is currently so)
        var pastFaceUpTime: TimeInterval = 0
        
        // how much time left before the opportunity runs out
        var bonusTimeRemaining: TimeInterval {
            max(0, bonusTimeLimit - faceUpTime)
        }
        
        // percent of bonus time remaining
        var bonusRemaining: Double {
            (bonusTimeLimit > 0 && bonusTimeRemaining > 0) ? bonusTimeRemaining / bonusTimeLimit : 0
        }
        
        // whether the card was matched during the bonus time period
        var hasEarnedBonus: Bool {
            isMatched && bonusTimeRemaining > 0
        }
        
        // whether we are currently face up, unmatched and have not yet used up the bonus window
        var isConsumingBonusTime: Bool {
            isFaceUp && !isMatched && bonusTimeRemaining > 0
        }
        
        // called when the card transition to face up state
        mutating private func startUsingBonusTime() {
            if isConsumingBonusTime, lastFaceUpDate == nil {
                lastFaceUpDate = Date()
            }
        }
        
        // called when the card transition to face down (or gets matched)
        mutating private func stopUsingBonusTime() {
            pastFaceUpTime = faceUpTime
            self.lastFaceUpDate = nil
        }
    }
    
    
}
