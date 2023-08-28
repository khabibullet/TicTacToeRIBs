//
//  OffGameBuilder.swift
//  TicTacToe
//
//  Created by Irek Khabibullin on 28.08.2023.
//  Copyright © 2023 Uber. All rights reserved.
//

import RIBs

protocol OffGameDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class OffGameComponent: Component<OffGameDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol OffGameBuildable: Buildable {
    func build(withListener listener: OffGameListener) -> OffGameRouting
}

final class OffGameBuilder: Builder<OffGameDependency>, OffGameBuildable {

    override init(dependency: OffGameDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: OffGameListener) -> OffGameRouting {
        let _ = OffGameComponent(dependency: dependency)
        
        let viewModel = OffGameViewModel()
        let view = OffGameView(viewModel: viewModel)
        let hostingController = OffGameHostingController(rootView: view)
        
        let interactor = OffGameInteractor(presenter: viewModel)
        interactor.listener = listener
        return OffGameRouter(interactor: interactor, viewController: hostingController)
    }
}
