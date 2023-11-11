//
//  MemoryGameModel.swift
//  memorize
//
//  Created by Aaron Bruckner on 10/14/23.
//

import Foundation

struct MemoryGame<CardContent: Equatable> {
    private(set) var score: Int = 0
    private(set) var cards: [Card] = []
    private var lastPickedCard: Card?
    
    init(pairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        for pairIndex in 0 ..< pairsOfCards {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(id: "\(pairIndex)-A", content: content))
            cards.append(Card(id: "\(pairIndex)-B", content: content))
        }
    }
    
    struct Card: Identifiable {
        let id: String
        var isFaceUp = false
        var isMatched = false
        let content: CardContent
        var badPickScore: Int {
            pickCount > 1 ? -1 : 0
        }
        private(set) var pickCount = 0
        
        mutating func flip() -> Card {
            if !isFaceUp {
                pickCount += 1
            }
            isFaceUp.toggle()
            return self
        }
    }
    
    mutating func shuffle() {
        cards.shuffle()
    }
    
    mutating func chooseCard(_ card: Card) {
        let selectedIndex = cards.firstIndex(where: {$0.id == card.id})!
        
        if (cards[selectedIndex].isFaceUp) {
            // Do nothing if selected card is already face up.
            return
        }
        
        flipCardAtIndex(selectedIndex)
        
        if let lastPickedCard = self.lastPickedCard {
            let lastPickedIndex = self.cards.firstIndex(where: {$0.id == lastPickedCard.id})!
            // User has made previous select and this is the second choice, see if the two selected cards match
            checkIfPairMatches(index1: lastPickedIndex, index2: selectedIndex)
            self.lastPickedCard = nil
        } else {
            // First choice in a pair
            lastPickedCard = card
            // Flip all other cards currently face up
            for (i, card) in cards.enumerated() {
                if card.isFaceUp && !card.isMatched && i != selectedIndex{
                    flipCardAtIndex(i)
                }
            }
        }
    }
    
    private mutating func flipCardAtIndex(_ i: Int) {
        cards[i] = cards[i].flip()
    }
    
    private mutating func checkIfPairMatches(index1: Int, index2: Int) {
        if cards[index1].content == cards[index2].content {
            markMatched(index1)
            markMatched(index2)
            score += 2
        } else {
            score += cards[index1].badPickScore + cards[index2].badPickScore
        }
    }
    
    private mutating func markMatched(_ i: Int) {
        var card = cards[i]
        card.isMatched.toggle()
        cards[i] = card
    }
}
