//
//  ScoreStream.swift
//  TicTacToe
//
//  Created by Irek Khabibullin on 29.08.2023.
//  Copyright © 2023 Uber. All rights reserved.
//

import RxSwift

public struct Score {
    let player1Score: Int
    let player2Score: Int

    static func equals(lhs: Score, rhs: Score) -> Bool {
        return lhs.player1Score == rhs.player1Score && lhs.player2Score == rhs.player2Score
    }
}

public protocol ScoreStream: class {
    var score: Observable<Score> { get }
}

protocol MutableScoreStream: ScoreStream {
    func updateScore(withWinner winner: PlayerKind)
}

class ScoreStreamImpl: MutableScoreStream {

    var score: Observable<Score> {
        return variable
            .asObservable()
            .distinctUntilChanged { (lhs: Score, rhs: Score) -> Bool in
                Score.equals(lhs: lhs, rhs: rhs)
            }
    }

    func updateScore(withWinner winner: PlayerKind) {
        let newScore: Score = {
            let currentScore = variable.value
            if winner == .player1 {
                return Score(player1Score: currentScore.player1Score + 1,
                             player2Score: currentScore.player2Score)
            } else {
                return Score(player1Score: currentScore.player1Score,
                             player2Score: currentScore.player2Score + 1)
            }
        }()
        variable.value = newScore
    }

    // MARK: - Private

    private let variable = Variable<Score>(Score(player1Score: 0, player2Score: 0))
}
