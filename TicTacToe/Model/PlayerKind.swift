//
//  PlayerKind.swift
//  TicTacToe
//
//  Created by Irek Khabibullin on 30.08.2023.
//  Copyright © 2023 Uber. All rights reserved.
//

import UIKit

enum PlayerKind: Int {
    case player1
    case player2
    case none
    
    var color: UIColor {
        switch self {
            case .player1: return .blue
            case .player2: return .red
            case .none: return .gray
        }
    }
}
