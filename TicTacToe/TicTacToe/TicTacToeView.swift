//
//  TicTacToeView.swift
//  TicTacToe
//
//  Created by Irek Khabibullin on 28.08.2023.
//  Copyright © 2023 Uber. All rights reserved.
//

import SwiftUI

struct TicTacToeView: View {
    
    @ObservedObject var viewModel: TicTacToeViewModel
    
    var body: some View {
        ZStack {
            Color.gray
            VStack(spacing: 5) {
                ForEach(0...2, id: \.self) { row in
                    HStack(spacing: 5) {
                        ForEach(0...2, id: \.self) { column in
                            ZStack {
                                Color.white
                                Rectangle()
                                    .foregroundColor(.white)
                                switch viewModel.grid[row][column] {
                                    case .player1: Text("⭕️")
                                            .font(.largeTitle)
                                    case .player2: Text("❌")
                                            .font(.largeTitle)
                                    case .none: EmptyView()
                                }
                            }
                            .onTapGesture {
                                viewModel.didTapCell(row: row, column: column)
                            }
                        }
                    }
                }
            }
        }
        .aspectRatio(1.0, contentMode: .fit)
        .padding()
        .alert(
            viewModel.alertMessage,
            isPresented: $viewModel.isAlertShown
        ) {
            Button("OK", role: .cancel) {
                viewModel.didTapAlertOkButton()
            }
        }
    }
}

struct TicTacToeView_Previews: PreviewProvider {
    static var previews: some View {
        TicTacToeView(viewModel: TicTacToeViewModel())
    }
}
