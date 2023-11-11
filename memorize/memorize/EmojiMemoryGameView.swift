//
//  EmojiMemoryGameView.swift
//  memorize
//
//  Created by Aaron Bruckner on 10/10/23.
//

import SwiftUI


struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGameViewModel
    
    var body: some View {
        VStack {
            Text("Memorize!").font(.largeTitle).bold()
            cards
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
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 75))]){
                ForEach(viewModel.cards) { card in
                    CardView(card: card)
                        .aspectRatio(2/3, contentMode: .fit)
                }
            }
        }.animation(.linear)
    }
    
    var adjustmentButtons: some View {
        HStack {
            getCardAdjusterButton(handler: viewModel.onCardCountDecrement, iconSystemName: "rectangle.stack.badge.minus.fill")
                .disabled(viewModel.totalPairs == EmojiMemoryGameViewModel.MIN_CARD_PAIRS)
                .onTapGesture {
                    viewModel.onCardCountDecrement()
                }
            Spacer()
            Picker("Picker", selection: $viewModel.activeTheme){
                Text("Halloween").tag(EmojiMemoryGameViewModel.EmojiTheme.Halloween)
                Text("Food").tag(EmojiMemoryGameViewModel.EmojiTheme.Food)
                Text("Holiday").tag(EmojiMemoryGameViewModel.EmojiTheme.Holiday)
            }
            Spacer()
            getCardAdjusterButton(handler: viewModel.onCardCountIncrement, iconSystemName: "rectangle.stack.fill.badge.plus")
                .disabled(viewModel.totalPairs == EmojiMemoryGameViewModel.MAX_CARD_PAIRS)
                .onTapGesture {
                    viewModel.onCardCountIncrement()
                }
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
