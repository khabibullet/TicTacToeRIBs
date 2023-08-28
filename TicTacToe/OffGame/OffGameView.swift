//
//  OffGameView.swift
//  TicTacToe
//
//  Created by Irek Khabibullin on 28.08.2023.
//  Copyright © 2023 Uber. All rights reserved.
//

import SwiftUI

struct OffGameView: View {
    
    @ObservedObject var viewModel: OffGameViewModel
    
    var body: some View {
        ZStack {
            Color.yellow
                .edgesIgnoringSafeArea(.all)
            Button("Start Game") {
                viewModel.didTapStartGameButton()
            }
            .foregroundColor(.white)
            .padding()
            .background(.black)
            .clipShape(Capsule())
        }
    }
}

struct OffGameView_Previews: PreviewProvider {
    static var previews: some View {
        OffGameView(viewModel: OffGameViewModel())
    }
}
