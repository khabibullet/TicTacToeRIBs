//
//  TicTacToeViewController.swift
//  TicTacToe
//
//  Created by Irek Khabibullin on 28.08.2023.
//  Copyright © 2023 Uber. All rights reserved.
//

import RIBs
import RxSwift
import UIKit

protocol TicTacToePresentableListener: AnyObject {
    func placeCurrentPlayerMark(atRow row: Int, col: Int)
    func closeGame()
}

enum Playerkind: Int {
    case player1
    case player2
    case none
}

final class TicTacToeViewModel: ObservableObject, TicTacToePresentable {

    weak var listener: TicTacToePresentableListener?
    
    @Published var isSomeoneWon = false
    
    @Published var alertMessage = ""
    
    @Published var isAlertShown = false
    
    @Published var grid: [[Playerkind]] = [
        [.none, .none, .none],
        [.none, .none, .none],
        [.none, .none, .none]
    ]
    
    func didTapCell(row: Int, column: Int) {
        listener?.placeCurrentPlayerMark(atRow: row, col: column)
        print("")
    }
    
    func didTapAlertOkButton() {
        listener?.closeGame()
    }
    
    // MARK: - TicTacToePresentable
    
    func setInitialGrid(grid: [[Playerkind]]) {
        self.grid = grid
    }
    
    func markCell(row: Int, column: Int, player: Playerkind) {
        guard (0...2).contains(row), (0...2).contains(column) else { return }
        grid[row][column] = player
    }
    
    func showAlertMessage(string: String) {
        alertMessage = string
        isAlertShown = true
    }
    
    func closeAlert() {
        isAlertShown = false
    }
    
}
