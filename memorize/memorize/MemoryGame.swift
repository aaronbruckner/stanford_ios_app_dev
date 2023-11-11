//
//  MemoryGameModel.swift
//  memorize
//
//  Created by Aaron Bruckner on 10/14/23.
//

import Foundation

struct MemoryGame<CardContent> {
    private(set) var cards: [Card] = []
    
    init(pairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        for pairIndex in 0 ..< pairsOfCards {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(id: "\(pairIndex)-A", content: content))
            cards.append(Card(id: "\(pairIndex)-B", content: content))
        }
    }
    
    struct Card: Identifiable {
        let id: String
        var isFaceUp = true
        var isMatched = false
        let content: CardContent
        
        mutating func flip() -> Card {
            isFaceUp.toggle()
            return self
        }
    }
    
    mutating func shuffle() {
        cards.shuffle()
    }
    
    mutating func chooseCard(_ card: Card) {
        flipCardAtIndex(cards.firstIndex(where: {$0.id == card.id})!)
    }
    
    private mutating func flipCardAtIndex(_ i: Int) {
        cards[i] = cards[i].flip()
    }
}
