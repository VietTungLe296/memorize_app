//
//  DataSource.swift
//  Memorize
//
//  Created by Le Viet Tung on 29/08/2023.
//

import Foundation

final class DataSource {
    private static let animalEmojis = ["🐶", "🐱", "🐰", "🦁", "🐻", "🐯", "🐼", "🐵"].flatMap {element in
        [element, element]
    }
    
    private static let vehicleEmojis = ["🚗", "🚕", "🚑", "🚒", "🚚", "🚓", "🚜", "🚁"].flatMap {element in
        [element, element]
    }
    
    private static let foodEmojis = ["🌭", "🌮", "🍕", "🍉", "🍖", "🍑", "🌶️", "🥔"].flatMap {element in
        [element, element]
    }
    
    static let themes = [
        GameTheme(name: "Animal", emojis: animalEmojis, color: .orange),
        GameTheme(name: "Vehicle", emojis: vehicleEmojis, color: .blue),
        GameTheme(name: "Food", emojis: foodEmojis, color: .purple)
    ]
}
