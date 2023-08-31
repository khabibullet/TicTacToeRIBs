//
//  LoggedInRouter.swift
//  TicTacToe
//
//  Created by Irek Khabibullin on 25.08.2023.
//  Copyright © 2023 Uber. All rights reserved.
//

import RIBs

protocol LoggedInInteractable: Interactable,
                               OffGameListener,
                               TicTacToeListener {
    var router: LoggedInRouting? { get set }
    var listener: LoggedInListener? { get set }
}

protocol LoggedInViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
    func replaceModal(viewController: ViewControllable?)
}

final class LoggedInRouter: Router<LoggedInInteractable>, LoggedInRouting {

    init(interactor: LoggedInInteractable,
         viewController: LoggedInViewControllable,
         offGameBuilder: OffGameBuildable,
         ticTacToeBuilder: TicTacToeBuilder) {
        self.viewController = viewController
        self.offGameBuilder = offGameBuilder
        self.ticTacToeBuilder = ticTacToeBuilder
        super.init(interactor: interactor)
        interactor.router = self
    }
    
    func cleanupViews() {
        if currentChild != nil {
            viewController.replaceModal(viewController: nil)
        }
    }
    
    func routeToTicTacToe() {
        detachCurrentChild()

        attachTicTacToe()
    }
    
    func routeToOffGame() {
        detachCurrentChild()
        
        attachOffGame()
    }
    
    // MARK: - Private
    
    private let viewController: LoggedInViewControllable
    
    private let offGameBuilder: OffGameBuildable
    
    private let ticTacToeBuilder: TicTacToeBuildable
    
    private var currentChild: ViewableRouting?
    
    private func attachOffGame() {
        let offGame = offGameBuilder.build(withListener: interactor)
        currentChild = offGame
        attachChild(offGame)
        viewController.replaceModal(viewController: offGame.viewControllable)
    }
    
    private func attachTicTacToe() {
        let ticTacToe = ticTacToeBuilder.build(withListener: interactor)
        currentChild = ticTacToe
        attachChild(ticTacToe)
        viewController.replaceModal(viewController: ticTacToe.viewControllable)
    }
    
    private func detachCurrentChild() {
        if let currentChild = currentChild {
            detachChild(currentChild)
            viewController.replaceModal(viewController: nil)
        }
    }
}
