//
//  LoggedOutView.swift
//  TicTacToe
//
//  Created by Irek Khabibullin on 25.08.2023.
//  Copyright © 2023 Uber. All rights reserved.
//

import SwiftUI

struct LoggedOutView: View {
    
    @ObservedObject var viewModel: LoggedOutViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            Group {
                TextField("Player 1 name", text: $viewModel.player1NameText)
                TextField("Player 2 name", text: $viewModel.player2NameText)
            }
            .padding(EdgeInsets(top: 0, leading: 6, bottom: 0, trailing: 6))
            .frame(height: 44)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(lineWidth: 2.0)
            )
            Button("Login", action: viewModel.didTapLogin)
            .frame(maxWidth: .infinity, maxHeight: 44)
            .foregroundColor(.white)
            .background(Color.black)
            .cornerRadius(5)
        }
        .padding(80)
    }
}

struct LoggedOutView_Previews: PreviewProvider {
    static var previews: some View {
        LoggedOutView(viewModel: LoggedOutViewModel())
    }
}
