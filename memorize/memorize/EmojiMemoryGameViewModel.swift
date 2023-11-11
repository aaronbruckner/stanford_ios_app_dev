//
//  EmojiMemoryGameViewModel.swift
//  memorize
//
//  Created by Aaron Bruckner on 10/20/23.
//

import SwiftUI

class EmojiMemoryGameViewModel: ObservableObject {    
    static let DEFAULT_THEME = EmojiTheme.Halloween
    static let MIN_CARD_PAIRS = 2
    static let MAX_CARD_PAIRS = 12
    private static let STARTING_CARD_PAIRS = 6
    private static func createModelWithTotalPairs(_ pairsOfCards: Int, theme: EmojiTheme) -> MemoryGame<String> {
        var memoryGame = MemoryGame<String>(pairsOfCards: pairsOfCards) { pairIndex in
            return emojisByTheme[theme]![pairIndex]
        }
        
        memoryGame.shuffle()
        
        return memoryGame
    }
    private static let emojisByTheme: Dictionary<EmojiTheme, [String]> = [
        .Halloween: ["🎃", "🕷️", "👻", "👹", "🏚️", "💀", "🦇", "🧟‍♀️", "🕸️", "🪦", "⚰️", "🩸"],
        .Food: ["🍇", "🌽", "🍉", "🍌", "🍊", "🍅", "🥔", "🍰", "☕️", "🥛", "🍟", "🍔"],
        .Holiday: ["🎄", "🎁", "☃️", "⛷️", "🎅🏿", "🦌", "⭐️", "❄️", "🧣", "🍪", "🛷", "🕎"]
    ]
    
    @Published private var model = createModelWithTotalPairs(STARTING_CARD_PAIRS, theme: DEFAULT_THEME)
    @Published private (set) var totalPairs = STARTING_CARD_PAIRS {
        didSet {
            model = EmojiMemoryGameViewModel.createModelWithTotalPairs(
                totalPairs,
                theme: activeTheme
            )
        }
    }
    @Published var activeTheme: EmojiTheme = DEFAULT_THEME {
        didSet {
            model = EmojiMemoryGameViewModel.createModelWithTotalPairs(
                totalPairs,
                theme: activeTheme
            )
        }
    }

    
    enum EmojiTheme {
        case Halloween
        case Food
        // Emma's contributions
        case Holiday
    }
    
    var cards: [MemoryGame<String>.Card] {
        return model.cards
    }
    
    func shuffle() {
        model.shuffle()
    }
    
    func chooseCard(_ card: MemoryGame<String>.Card) {
        model.chooseCard(card)
    }
    
    func onCardCountIncrement() {
        if totalPairs < EmojiMemoryGameViewModel.MAX_CARD_PAIRS {
            totalPairs += 1
        }
    }
    
    func onCardCountDecrement() {
        if totalPairs > EmojiMemoryGameViewModel.MIN_CARD_PAIRS {
            totalPairs -= 1
        }
    }
}
