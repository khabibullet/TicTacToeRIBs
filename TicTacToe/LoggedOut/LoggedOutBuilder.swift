//
//  LoggedOutBuilder.swift
//  TicTacToe
//
//  Created by Irek Khabibullin on 25.08.2023.
//  Copyright © 2023 Uber. All rights reserved.
//

import RIBs

protocol LoggedOutDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class LoggedOutComponent: Component<LoggedOutDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol LoggedOutBuildable: Buildable {
    func build(withListener listener: LoggedOutListener) -> LoggedOutRouting
}

final class LoggedOutBuilder: Builder<LoggedOutDependency>, LoggedOutBuildable {

    override init(dependency: LoggedOutDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: LoggedOutListener) -> LoggedOutRouting {
        let _ = LoggedOutComponent(dependency: dependency)
        let viewModel = LoggedOutViewModel()
        let view = LoggedOutView(viewModel: viewModel)
        let hostingController = LoggedOutHostingController(rootView: view)
        
        let interactor = LoggedOutInteractor(presenter: viewModel)
        interactor.listener = listener
        return LoggedOutRouter(interactor: interactor, viewController: hostingController)
    }
}
