//
//  MemoryCardView.swift
//  Memorize
//
//  Created by Le Viet Tung on 28/08/2023.
//

import SwiftUI

struct CardView: View {
    let card: MemoryGame<String>.Card
    
    init(_ card: MemoryGame<String>.Card) {
        self.card = card
    }
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(card.content)
                    .font(.system(size: 40))
            }
     
            base.fill().opacity(card.isFaceUp ? 0 : 1)
        }
        .opacity(card.isMatched ? 0 : 1)
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(MemoryGame<String>.Card(isFaceUp: true, content: "👻"))
            .foregroundColor(.orange)
    }
}

