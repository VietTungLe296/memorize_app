//
//  MemoryGame.swift
//  Memorize
//
//  Created by Le Viet Tung on 29/08/2023.
//

import Foundation

struct MemoryGame<CardContent: Equatable> {
    private(set) var cards: [Card]
    private(set) var theme: GameTheme
    private(set) var highestStreak: Int
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter { cards[$0].isFaceUp }.only }
        set { cards.indices.forEach { cards[$0].isFaceUp = (newValue == $0) } }
    }
    
    init() {
        cards = []
        
        theme = DataSource.themes.randomElement()!
        for emoji in theme.emojis {
            guard let cardContent = emoji as? CardContent else { continue }
            cards.append(Card(content: cardContent))
        }
        
        if let highestStreak = UserDefaults.standard.value(forKey: "highest_streak") as? Int {
            self.highestStreak = highestStreak
        } else {
            self.highestStreak = 0
        }
        
        /* Clear user highest score
         UserDefaults.standard.removeObject(forKey: "highest_streak")
         */
    }
    
    mutating func choose(_ card: Card) -> Bool {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }) {
            if !cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched {
                if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                    if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                        cards[chosenIndex].isMatched = true
                        cards[potentialMatchIndex].isMatched = true
                    } else {
                        cards[potentialMatchIndex].isFaceUp = false
                    }
                } else {
                    indexOfTheOneAndOnlyFaceUpCard = chosenIndex
                }
                
                cards[chosenIndex].isFaceUp = true
            }
        }
        
        return cards.allSatisfy { $0.isMatched == true }
    }
    
    mutating func startGame() {
        cards.shuffle()
    }
    
    mutating func resetGame() {
        cards.removeAll()
        
        let filteredThemes = DataSource.themes.filter{ $0 != self.theme }
        theme = filteredThemes.randomElement()!
        for emoji in theme.emojis {
            guard let cardContent = emoji as? CardContent else { continue }
            cards.append(Card(content: cardContent))
        }
    }
    
    mutating func saveNewHighestStreak(_ newHighestStreak: Int) {
        highestStreak = newHighestStreak
        UserDefaults.standard.set(newHighestStreak, forKey: "highest_streak")
        UserDefaults.standard.synchronize()
    }
    
    struct Card: Equatable, Identifiable {
        var id = UUID().uuidString
        
        var isFaceUp = false
        var isMatched = false
        var content: CardContent
    }
}

extension Array {
    var only: Element? {
        return count == 1 ? first : nil
    }
}
