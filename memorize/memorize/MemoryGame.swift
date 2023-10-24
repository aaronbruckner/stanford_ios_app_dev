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
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
    }
    
    struct Card {
        var isFaceUp = true
        var isMatched = false
        let content: CardContent
    }
    
    mutating func choose(_ card: Card) {

    }
}
