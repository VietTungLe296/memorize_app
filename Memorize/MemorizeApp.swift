//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Le Viet Tung on 28/08/2023.
//

import SwiftUI

@main
struct MemorizeApp: App {
    @StateObject var game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            GameView(viewModel: game)
        }
    }
}

