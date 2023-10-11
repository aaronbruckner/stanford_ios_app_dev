//
//  ContentView.swift
//  memorize
//
//  Created by Aaron Bruckner on 10/10/23.
//

import SwiftUI

struct ContentView: View {
    let emojis: [String] = ["🎃", "🕷️", "👻", "👹"]
    @State var cardCount = 4
    
    var body: some View {
        VStack {
            cards
            Spacer()
            adjustmentButtons
        }
        .padding()
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(), GridItem(), GridItem()]){
            ForEach(0..<cardCount, id: \.self) { i in
                Card(content: emojis[i], isFaceUp: true)
            }
        }
    }
    
    var adjustmentButtons: some View {
        HStack {
            getCardAdjusterButton(adjustment: -1, iconSystemName: "rectangle.stack.badge.minus.fill")
                .disabled(cardCount == 1)
            getCardAdjusterButton(adjustment: +1, iconSystemName: "rectangle.stack.fill.badge.plus")
                .disabled(cardCount == emojis.count)
        }.font(.largeTitle)
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
            if isFaceUp {
                base.foregroundColor(.white)
                base.strokeBorder(lineWidth: 4)
            } else {
                base.fill()
            }
            Text(content).opacity(isFaceUp ? 1 : 0).font(.largeTitle)
        }.onTapGesture {
            isFaceUp.toggle()
        }
    }
}

#Preview {
    ContentView()
}
