//
//  GameView.swift
//  Memorize
//
//  Created by Le Viet Tung on 28/08/2023.
//

import SwiftUI

struct GameView: View {
    @Environment(\.colorScheme) private var colorScheme
    
    @ObservedObject var viewModel: EmojiMemoryGame
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    private let aspectRatio: CGFloat = 1
    
    var body: some View {
        VStack {
            header
            
            cards
                .padding()
                .foregroundColor(viewModel.theme.color)
                .animation(viewModel.status == .reset ? nil : .default, value: viewModel.cards)
            
            footer
            
            Spacer(minLength: 50)
        }
        .background(
            Color(red: 191/255, green: 142/255, blue: 85/255)
                .blur(radius: 10)
                .ignoresSafeArea()
        )
        .onReceive(timer) { _ in
            if viewModel.status == .start {
                viewModel.startCountDown()
            }
        }
        .alert(isPresented: $viewModel.showAlertResult) {
            Alert(
                title: Text("MEMORIZE"),
                message: Text(viewModel.result),
                dismissButton: .default(Text("OK"), action: {
                    viewModel.status = .reset
                })
            )
        }
    }
    
    private var header: some View {
        VStack(spacing: 20) {
            Text("Memorize!")
                .bold()
                .font(.largeTitle)
            
            Text(viewModel.theme.name)
                .font(.title)
            
            Text("Current Streak: \(viewModel.currentStreak) / Highest Streak: \(viewModel.highestStreak)")
                .italic()
        }
    }
    
    private var cards: some View {
        AspectVGrid(viewModel.cards, aspectRatio: aspectRatio) { card in
            CardView(card)
                .padding(5)
                .onTapGesture {
                    viewModel.choose(card)
                }
                .disabled(viewModel.status != .start)
        }
    }
    
    private var footer: some View {
        VStack(spacing: 20) {
            Text("\(viewModel.countdown)")
                .font(.system(size: 60))
                .bold()
                .foregroundColor(viewModel.countdown > 10 ? .white : .red)
                .animation(.default, value: viewModel.countdown)
            
            HStack(spacing: 50) {
                Button("Reset") {
                    viewModel.status = .reset
                }
                .padding()
                .foregroundColor(.white)
                .background(.red)
                
                Button("Start") {
                    viewModel.status = .start
                }
                .padding()
                .foregroundColor(.white)
                .background(viewModel.status == .start ? .gray : .green)
                .disabled(viewModel.status == .start)
            }
        }
    }
}

struct EmojiMemoryGameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(viewModel: .init())
    }
}
