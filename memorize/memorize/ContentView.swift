//
//  ContentView.swift
//  memorize
//
//  Created by Aaron Bruckner on 10/10/23.
//

import SwiftUI

enum EmojiTheme {
    case Halloween
    case Food
    // Emma's contributions
    case Holiday
}

let emojisByTheme: Dictionary<EmojiTheme, [String]> = [
    .Halloween: ["🎃", "🕷️", "👻", "👹", "🏚️", "💀", "🦇", "🧟‍♀️", "🕸️", "🪦", "⚰️", "🩸"],
    .Food: ["🍇", "🌽", "🍉", "🍌", "🍊", "🍅", "🥔", "🍰", "☕️", "🥛", "🍟", "🍔"],
    .Holiday: ["🎄", "🎁", "☃️", "⛷️", "🎅🏿", "🦌", "⭐️", "❄️", "🧣", "🍪", "🛷", "🕎"]
]

func generateEmojiPairs(emojiTheme: EmojiTheme, totalPairs: Int) -> [String] {
    let selectedEmojis = emojisByTheme[emojiTheme]!.shuffled()[0..<totalPairs]
    return (selectedEmojis + selectedEmojis).shuffled()
}

let DEFAULT_THEME = EmojiTheme.Halloween
let STARTING_CARD_PAIRS = 4

struct ContentView: View {
    @State var cardCount = STARTING_CARD_PAIRS
    @State var activeTheme: EmojiTheme = DEFAULT_THEME
    @State var activeEmojis: [String] = generateEmojiPairs(emojiTheme: DEFAULT_THEME, totalPairs: STARTING_CARD_PAIRS)
    @State var cardStates = [Bool](repeating: false, count: STARTING_CARD_PAIRS * 2)
    
    var body: some View {
        VStack {
            Text("Memorize!").font(.largeTitle).bold()
            ScrollView {
                cards
            }
            Spacer()
            adjustmentButtons
        }
        .padding()
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 75))]){
            ForEach(0..<activeEmojis.count, id: \.self) { i in
                Card(content: activeEmojis[i], isFaceUp: cardStates[i]) {
                    cardStates[i].toggle()
                }.aspectRatio(2/3, contentMode: .fit)
            }
        }
    }
    
    var adjustmentButtons: some View {
        HStack {
            getCardAdjusterButton(adjustment: -1, iconSystemName: "rectangle.stack.badge.minus.fill")
                .disabled(cardCount == 1)
            Spacer()
            Picker("Picker", selection: $activeTheme){
                Text("Halloween").tag(EmojiTheme.Halloween)
                Text("Food").tag(EmojiTheme.Food)
                Text("Holiday").tag(EmojiTheme.Holiday)
            }.onChange(of: activeTheme) {
                regenerateActiveEmojis()
            }
            Spacer()
            getCardAdjusterButton(adjustment: +1, iconSystemName: "rectangle.stack.fill.badge.plus")
                .disabled(cardCount == emojisByTheme[activeTheme]!.count)
        }.font(.largeTitle).padding()
    }
    
    func getCardAdjusterButton(adjustment: Int, iconSystemName: String) -> some View {
        Button(action: {
            cardCount += adjustment
            regenerateActiveEmojis()
        }, label: {
            Image(systemName: iconSystemName)
        })
    }
    
    func regenerateActiveEmojis() -> Void {
        activeEmojis = generateEmojiPairs(emojiTheme: activeTheme, totalPairs: cardCount)
        cardStates = [Bool](repeating: false, count: cardCount * 2)
    }
    
    struct Card: View {
        let content: String
        let isFaceUp: Bool
        let onTap: () -> Void
        
        var body: some View {
            ZStack{
                let base = RoundedRectangle(cornerRadius: 12)
                Group {
                    base.foregroundColor(.white)
                    base.strokeBorder(lineWidth: 4)
                    Text(content).font(.largeTitle).padding()
                }.opacity(isFaceUp ? 1 : 0)
                base.fill().opacity(isFaceUp ? 0 : 1)
                
            }.onTapGesture {
                onTap()
            }
        }
    }
}

#Preview {
    ContentView()
}
