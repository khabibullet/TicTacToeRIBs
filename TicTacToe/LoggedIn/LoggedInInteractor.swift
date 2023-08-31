//
//  LoggedInInteractor.swift
//  TicTacToe
//
//  Created by Irek Khabibullin on 25.08.2023.
//  Copyright © 2023 Uber. All rights reserved.
//

import RIBs
import RxSwift

protocol LoggedInRouting: Routing {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
    func routeToTicTacToe()
    func routeToOffGame()
    func cleanupViews()
}

protocol LoggedInListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class LoggedInInteractor: Interactor, LoggedInInteractable, LoggedInActionableItem {
    
    weak var router: LoggedInRouting?
    weak var listener: LoggedInListener?
    
    private let mutableScoreStream: MutableScoreStream

    init(mutableScoreStream: MutableScoreStream) {
        self.mutableScoreStream = mutableScoreStream
    }
    
    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
        router?.routeToOffGame()
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
        router?.cleanupViews()
    }
    
    func gameDidEnd(with winner: PlayerKind) {
        if winner != .none {
            mutableScoreStream.updateScore(withWinner: winner)
        }
        router?.routeToOffGame()
    }
    
    func startTicTacToe() {
        router?.routeToTicTacToe()
    }
    
    // MARK: - LoggedInActionableItem

    func launchGame(with id: String?) -> Observable<(LoggedInActionableItem, ())> {
        
        if id == "ticTacToe" {
            router?.routeToTicTacToe()
        }

        return Observable.just((self, ()))
    }
    
}
