//
//  ContentView.swift
//  Memorize
//
//  Created by Tan Tan on 6/17/22.
//

import SwiftUI

struct ContentView: View {
    let cols = [GridItem(.adaptive(minimum: 65))]
    let viewModel: EmojiMemoryGame = .init()
    
    var body: some View {
        VStack {
            LazyVGrid(columns: cols) {
                ForEach(viewModel.cards, id: \.id) { card in
                    CardView(content: card.content)
                        .aspectRatio(2/3, contentMode: .fit)
                }
            }
            
            Spacer()
        }
        .padding(.horizontal)
    }
}

struct CardView: View {
    let content: String
    @State var isFaceUp: Bool = true
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            if isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.stroke(.red, lineWidth: 2)
            } else {
                shape.fill().foregroundColor(.red)
            }

            Text(content)
                .font(.largeTitle)
        }
        .onTapGesture {
            self.isFaceUp.toggle()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
