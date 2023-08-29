//
//  TicTacToeInteractor.swift
//  TicTacToe
//
//  Created by Irek Khabibullin on 28.08.2023.
//  Copyright © 2023 Uber. All rights reserved.
//

import RIBs
import RxSwift

protocol TicTacToeRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol TicTacToePresentable: Presentable {
    var listener: TicTacToePresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
    func setInitialGrid(grid: [[PlayerKind]])
    func markCell(row: Int, column: Int, player: PlayerKind)
    func showAlertMessage(string: String)
    func closeAlert()
}

protocol TicTacToeListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
    func gameDidEnd(with winner: PlayerKind)
}

final class TicTacToeInteractor: PresentableInteractor<TicTacToePresentable>, TicTacToeInteractable, TicTacToePresentableListener {
    
    weak var router: TicTacToeRouting?
    weak var listener: TicTacToeListener?
    
    private var currentPlayer = PlayerKind.player1
    
    private let player1Name: String
    private let player2Name: String
    
    private var grid: [[PlayerKind]] = [
        [.none, .none, .none],
        [.none, .none, .none],
        [.none, .none, .none]
    ]
    
    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    init(presenter: TicTacToePresentable,
                  player1Name: String,
                  player2Name: String) {
        self.player1Name = player1Name
        self.player2Name = player2Name
        super.init(presenter: presenter)
        presenter.listener = self
        presenter.setInitialGrid(grid: grid)
    }
    
    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
    }
    
    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
    
    func placeCurrentPlayerMark(atRow row: Int, col: Int) {
        guard grid[row][col] == .none else { return }
        grid[row][col] = currentPlayer
        presenter.markCell(row: row, column: col, player: currentPlayer)
        if isSomeWinner() {
            announceWinner()
        } else if !grid.flatMap({ $0 }).contains(where: { $0 == .none }) {
            currentPlayer = .none
            announceDraw()
        } else {
            switchPlayer()
        }
    }
    
    func closeGame() {
        listener?.gameDidEnd(with: currentPlayer)
    }
    
    //MARK: - Private
    
    private func switchPlayer() {
        if currentPlayer == .player1 {
            currentPlayer = .player2
        } else {
            currentPlayer = .player1
        }
    }
    
    private func isSomeWinner() -> Bool {
        if isTripple(grid[0]) || isTripple(grid[1]) || isTripple(grid[2]) {
            return true
        }
        if isTripple([grid[0][0], grid[1][0], grid[2][0]])
            || isTripple([grid[0][1], grid[1][1], grid[2][1]])
            || isTripple([grid[0][2], grid[1][2], grid[2][2]]) {
            return true
        }
        if isTripple([grid[0][0], grid[1][1], grid[2][2]])
            || isTripple([grid[2][0], grid[1][1], grid[0][2]]) {
            return true
        }
        return false
    }
    
    private func isTripple(_ tripple: [PlayerKind]) -> Bool {
        if tripple[0] == tripple[1], tripple[0] == tripple[2], tripple[0] != .none {
            return true
        } else {
            return false
        }
    }
    
    private func announceDraw() {
        presenter.showAlertMessage(string: "It is draw!")
    }
    
    private func announceWinner() {
        let player = currentPlayer == .player1 ? player1Name : player2Name
        presenter.showAlertMessage(string: "\(player) won!")
    }
}
