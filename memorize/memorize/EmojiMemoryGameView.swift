//
//  EmojiMemoryGameView.swift
//  memorize
//
//  Created by Aaron Bruckner on 10/10/23.
//

import SwiftUI


struct EmojiMemoryGameView: View {
    private static let MIN_CARD_COUNT: Int = 2
    private static let MAX_CARD_COUNT: Int = 24
    
    @ObservedObject var viewModel: EmojiMemoryGameViewModel
    
    @State private var activeTheme: EmojiMemoryGameViewModel.EmojiTheme = EmojiMemoryGameViewModel.DEFAULT_THEME
    
    var body: some View {
        VStack {
            Text("Memorize!").font(.largeTitle).bold()
            ScrollView {
                cards
            }
            Spacer()
            adjustmentButtons
            Button(action: {
                viewModel.shuffle()
            }, label: {
                Text("Shuffle")
            })
        }
        .padding()
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 75))]){
            ForEach(0..<viewModel.cards.count, id: \.self) { i in
                CardView(card: viewModel.cards[i])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
    }
    
    var adjustmentButtons: some View {
        HStack {
            getCardAdjusterButton(handler: viewModel.onCardCountDecrement, iconSystemName: "rectangle.stack.badge.minus.fill")
                .disabled(viewModel.cards.count == EmojiMemoryGameView.MIN_CARD_COUNT)
            Spacer()
            Picker("Picker", selection: $activeTheme){
                Text("Halloween").tag(EmojiMemoryGameViewModel.EmojiTheme.Halloween)
                Text("Food").tag(EmojiMemoryGameViewModel.EmojiTheme.Food)
                Text("Holiday").tag(EmojiMemoryGameViewModel.EmojiTheme.Holiday)
            }.onChange(of: activeTheme) {
                viewModel.onEmojiThemeChange(activeTheme)
            }
            Spacer()
            getCardAdjusterButton(handler: viewModel.onCardCountIncrement, iconSystemName: "rectangle.stack.fill.badge.plus")
                .disabled(viewModel.cards.count == EmojiMemoryGameView.MAX_CARD_COUNT)
        }.font(.largeTitle).padding()
    }
    
    func getCardAdjusterButton(handler: @escaping () -> Void, iconSystemName: String) -> some View {
        Button(action: {
            handler()
        }, label: {
            Image(systemName: iconSystemName)
        })
    }
    
    private struct CardView: View {
        let card: MemoryGame<String>.Card
        
        var body: some View {
            ZStack{
                let base = RoundedRectangle(cornerRadius: 12)
                Group {
                    base.foregroundColor(.white)
                    base.strokeBorder(lineWidth: 4)
                    Text(card.content).font(.largeTitle).padding()
                }.opacity(card.isFaceUp ? 1 : 0)
                base.fill().opacity(card.isFaceUp ? 0 : 1)
                
            }.onTapGesture {
                // TODO Handle tap
            }
        }
    }
}

#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGameViewModel())
}
