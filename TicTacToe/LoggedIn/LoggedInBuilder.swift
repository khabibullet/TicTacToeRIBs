//
//  LoggedInBuilder.swift
//  TicTacToe
//
//  Created by Irek Khabibullin on 25.08.2023.
//  Copyright © 2023 Uber. All rights reserved.
//

import RIBs

protocol LoggedInDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
    var loggedInViewController: LoggedInViewControllable { get }
}

final class LoggedInComponent: Component<LoggedInDependency> {

    let player1Name: String
    let player2Name: String
    
    fileprivate var loggedInViewController: LoggedInViewControllable {
        return dependency.loggedInViewController
    }
    
    var mutableScoreStream: MutableScoreStream {
        return shared { ScoreStreamImpl() }
    }
    
    init(dependency: LoggedInDependency,
         player1Name: String,
         player2Name: String) {
        self.player1Name = player1Name
        self.player2Name = player2Name
        super.init(dependency: dependency)
    }
}

// MARK: - Builder

protocol LoggedInBuildable: Buildable {
    func build(withListener listener: LoggedInListener,
               player1Name: String,
               player2Name: String) -> (router: LoggedInRouting,
                                        actionableItem: LoggedInActionableItem)
}

final class LoggedInBuilder: Builder<LoggedInDependency>, LoggedInBuildable {

    override init(dependency: LoggedInDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: LoggedInListener,
               player1Name: String,
               player2Name: String) -> (router: LoggedInRouting,
                                        actionableItem: LoggedInActionableItem) {
        let component = LoggedInComponent(dependency: dependency,
                                          player1Name: player1Name,
                                          player2Name: player2Name)
        
        let interactor = LoggedInInteractor(mutableScoreStream: component.mutableScoreStream)
        interactor.listener = listener
        
        let offGameBuilder = OffGameBuilder(dependency: component)
        let ticTacToeBuilder = TicTacToeBuilder(dependency: component)
        
        let router = LoggedInRouter(interactor: interactor,
                                    viewController: component.loggedInViewController,
                                    offGameBuilder: offGameBuilder,
                                    ticTacToeBuilder: ticTacToeBuilder)
        return (router, interactor)
    }
}
