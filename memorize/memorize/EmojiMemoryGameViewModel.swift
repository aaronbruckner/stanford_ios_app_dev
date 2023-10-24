//
//  EmojiMemoryGameViewModel.swift
//  memorize
//
//  Created by Aaron Bruckner on 10/20/23.
//

import SwiftUI

class EmojiMemoryGameViewModel: ObservableObject {    
    static let DEFAULT_THEME = EmojiTheme.Halloween
    private static let STARTING_CARD_PAIRS = 6
    private static func createModelWithTotalPairs(_ pairsOfCards: Int, theme: EmojiTheme) -> MemoryGame<String> {
        return MemoryGame<String>(pairsOfCards: pairsOfCards) { pairIndex in
            return emojisByTheme[theme]![pairIndex]
        }
    }
    private static let emojisByTheme: Dictionary<EmojiTheme, [String]> = [
        .Halloween: ["🎃", "🕷️", "👻", "👹", "🏚️", "💀", "🦇", "🧟‍♀️", "🕸️", "🪦", "⚰️", "🩸"],
        .Food: ["🍇", "🌽", "🍉", "🍌", "🍊", "🍅", "🥔", "🍰", "☕️", "🥛", "🍟", "🍔"],
        .Holiday: ["🎄", "🎁", "☃️", "⛷️", "🎅🏿", "🦌", "⭐️", "❄️", "🧣", "🍪", "🛷", "🕎"]
    ]
    
    @Published private var model = createModelWithTotalPairs(STARTING_CARD_PAIRS, theme: DEFAULT_THEME)
    private var activeTheme: EmojiTheme = DEFAULT_THEME

    
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
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    
    func onEmojiThemeChange(_ theme: EmojiTheme) {
        // TODO: Impl onEmojiThemeChange
    }
    
    func onCardCountIncrement() {
        // TODO: Impl onCardCountIncrement
    }
    
    func onCardCountDecrement() {
        // TODO: Impl onCardCountDecrement
    }
}
