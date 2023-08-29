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
    var player1Name: String { get }
    var player2Name: String { get }
    var scoreStream: ScoreStream { get }
}

final class OffGameComponent: Component<OffGameDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
    
    fileprivate var player1Name: String {
        return dependency.player1Name
    }

    fileprivate var player2Name: String {
        return dependency.player2Name
    }
    
    fileprivate var scoreStream: ScoreStream {
        return dependency.scoreStream
    }
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
        let component = OffGameComponent(dependency: dependency)
        
        let viewModel = OffGameViewModel(player1Name: component.player1Name,
                                         player2Name: component.player2Name)
        let view = OffGameView(viewModel: viewModel)
        let hostingController = OffGameHostingController(rootView: view)
        
        let interactor = OffGameInteractor(presenter: viewModel,
                                           scoreStream: component.scoreStream)
        interactor.listener = listener
        return OffGameRouter(interactor: interactor, viewController: hostingController)
    }
}
