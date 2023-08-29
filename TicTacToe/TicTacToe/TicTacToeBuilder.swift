//
//  TicTacToeBuilder.swift
//  TicTacToe
//
//  Created by Irek Khabibullin on 28.08.2023.
//  Copyright © 2023 Uber. All rights reserved.
//

import RIBs

protocol TicTacToeDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
    var player1Name: String { get }
    var player2Name: String { get }
}

final class TicTacToeComponent: Component<TicTacToeDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
    
    fileprivate var player1Name: String {
        return dependency.player1Name
    }

    fileprivate var player2Name: String {
        return dependency.player2Name
    }
}

// MARK: - Builder

protocol TicTacToeBuildable: Buildable {
    func build(withListener listener: TicTacToeListener) -> TicTacToeRouting
}

final class TicTacToeBuilder: Builder<TicTacToeDependency>, TicTacToeBuildable {

    override init(dependency: TicTacToeDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: TicTacToeListener) -> TicTacToeRouting {
        let component = TicTacToeComponent(dependency: dependency)
        
        let viewModel = TicTacToeViewModel()
        let view = TicTacToeView(viewModel: viewModel)
        let hostingController = TicTacToeHostingController(rootView: view)
        
        let interactor = TicTacToeInteractor(presenter: viewModel,
                                             player1Name: component.player1Name,
                                             player2Name: component.player2Name)
        interactor.listener = listener
        
        return TicTacToeRouter(interactor: interactor, viewController: hostingController)
    }
}
