//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Le Viet Tung on 29/08/2023.
//

import Foundation

enum GameStatus {
    case idle
    case start
    case reset
    case lose
    case won
}

final class EmojiMemoryGame: ObservableObject {
    @Published private var model: MemoryGame<String>
    @Published var status: GameStatus = .idle {
        didSet {
            switch status {
            case .idle:
                break
            case .start:
                model.startGame()
            case .reset:
                showAlertResult = false
                countdown = 30
                model.resetGame()
            case .lose:
                showAlertResult = true
                result = "You lose, mate! Try again, huh? 🫤"
            case .won:
                showAlertResult = true
                currentStreak += 1
                if currentStreak > highestStreak {
                    model.saveNewHighestStreak(currentStreak)
                    result = "You've created a new record, champion 🥇"
                } else {
                    result = "Very good! Keep going 👌"
                }
            }
        }
    }
    @Published var countdown: Int = 30
    @Published var showAlertResult = false
    @Published var result = ""
    @Published var currentStreak = 0
    
    init() {
        self.model = .init()
    }
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    var theme: GameTheme {
        return model.theme
    }
    
    var highestStreak: Int {
        return model.highestStreak
    }
    
    func choose(_ card: MemoryGame<String>.Card) {
        if model.choose(card) {
            status = .won
        }
    }
    
    func startCountDown() {
        if countdown > 0 {
            countdown -= 1
            if countdown == 0 {
                status = .lose
            }
        }
    }
}
