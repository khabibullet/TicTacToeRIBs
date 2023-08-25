//
//  LoggedOutViewModel.swift
//  TicTacToe
//
//  Created by Irek Khabibullin on 25.08.2023.
//  Copyright © 2023 Uber. All rights reserved.
//

import RIBs
import RxSwift
import SwiftUI

protocol LoggedOutPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
    
    func login(withPlayer1Name player1Name: String?, player2Name: String?)
    
}

class LoggedOutViewModel: ObservableObject, LoggedOutPresentable {
    
    weak var listener: LoggedOutPresentableListener?
    
    @Published var player1NameText = ""
    
    @Published var player2NameText = ""
    
    func didTapLogin() {
        listener?.login(withPlayer1Name: player1NameText, player2Name: player2NameText)
    }
    
}
