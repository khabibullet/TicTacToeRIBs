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
    
    func didTapStartGameButton() {
        listener?.startGame()
    }
    
}
