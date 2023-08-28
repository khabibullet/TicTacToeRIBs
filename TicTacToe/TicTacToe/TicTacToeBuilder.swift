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
}

final class TicTacToeComponent: Component<TicTacToeDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
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
        let _ = TicTacToeComponent(dependency: dependency)
        
        let viewModel = TicTacToeViewModel()
        let view = TicTacToeView(viewModel: viewModel)
        let hostingController = TicTacToeHostingController(rootView: view)
        
        let interactor = TicTacToeInteractor(presenter: viewModel)
        interactor.listener = listener
        
        return TicTacToeRouter(interactor: interactor, viewController: hostingController)
    }
}
