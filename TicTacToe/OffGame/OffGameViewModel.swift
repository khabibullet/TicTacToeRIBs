//
//  OffGameViewModel.swift
//  TicTacToe
//
//  Created by Irek Khabibullin on 28.08.2023.
//  Copyright © 2023 Uber. All rights reserved.
//

import RIBs
import RxSwift
import SwiftUI

protocol OffGamePresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
    func startGame()
}

class OffGameViewModel: ObservableObject, OffGamePresentable {
    
    weak var listener: OffGamePresentableListener?
    
    let player1Name: String
    let player2Name: String
    
    @Published var score: Score = Score(player1Score: 0, player2Score: 0)
    
    init(player1Name: String,
         player2Name: String) {
        self.player1Name = player1Name
        self.player2Name = player2Name
    }
    
    func didTapStartGameButton() {
        listener?.startGame()
    }
    
    // MARK: - OffGamePresentable
    
    func set(score: Score) {
        self.score = score
    }
}
