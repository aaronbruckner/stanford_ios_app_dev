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

struct ContentView: View {
    let emojis: Dictionary<EmojiTheme, [String]> = [
        .Halloween: ["🎃", "🕷️", "👻", "👹", "🏚️", "💀", "🦇", "🧟‍♀️", "🕸️", "🪦", "⚰️", "🩸"],
        .Food: ["🍇", "🌽", "🍉", "🍌", "🍊", "🍅", "🥔", "🍰", "☕️", "🥛", "🍟", "🍔"],
        .Holiday: ["🎄", "🎁", "☃️", "⛷️", "🎅🏿", "🦌", "⭐️", "❄️", "🧣", "🍪", "🛷", "🕎"]
    ]
    @State var cardCount = 4
    @State var activeTheme: EmojiTheme = .Halloween
    
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
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]){
            ForEach(0..<cardCount, id: \.self) { i in
                Card(content: emojis[activeTheme]![i], isFaceUp: true)
                    .aspectRatio(2/3, contentMode: .fit)
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
            }
            Spacer()
            getCardAdjusterButton(adjustment: +1, iconSystemName: "rectangle.stack.fill.badge.plus")
                .disabled(cardCount == emojis.count)
        }.font(.largeTitle).padding()
    }
    
    func getCardAdjusterButton(adjustment: Int, iconSystemName: String) -> some View {
        Button(action: {
            cardCount += adjustment
        }, label: {
            Image(systemName: iconSystemName)
        })
    }
}

struct Card: View {
    let content: String
    @State var isFaceUp = true
    
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
            isFaceUp.toggle()
        }
    }
}

#Preview {
    ContentView()
}
