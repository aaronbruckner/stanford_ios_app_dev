//
//  memorizeApp.swift
//  memorize
//
//  Created by Aaron Bruckner on 10/10/23.
//

import SwiftUI

@main
struct memorizeApp: App {
    @StateObject var emojiMemoryGameViewModel = EmojiMemoryGameViewModel()
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(viewModel: emojiMemoryGameViewModel)
        }
    }
}
