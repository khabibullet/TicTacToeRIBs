//
//  TicTacToeMocks.swift
//  TicTacToeTest
//
//  Created by Irek Khabibullin on 29.08.2023.
//  Copyright © 2023 Uber. All rights reserved.
//

@testable import TicTacToe
import RIBs
import RxSwift
import UIKit

// MARK: - LoggedInBuildableMock class

/// A LoggedInBuildableMock class used for testing.
class LoggedInBuildableMock: LoggedInBuildable {
    
    

    // Function Handlers
    var buildHandler: ((_ listener: LoggedInListener,
                        _ player1Name: String,
                        _ player2Name: String) -> (LoggedInRouting,
                                                          LoggedInActionableItem))?
    var buildCallCount: Int = 0

    init() {
    }

    func build(withListener listener: TicTacToe.LoggedInListener,
               player1Name: String,
               player2Name: String) -> (router: TicTacToe.LoggedInRouting,
                                        actionableItem: TicTacToe.LoggedInActionableItem) {
        buildCallCount += 1
        if let buildHandler {
            return buildHandler(listener, player1Name, player2Name)
        }
        fatalError("Function build returns a value that can't be handled with a default value and its handler must be set")
    }
}

// MARK: - LoggedInInteractableMock class

/// A LoggedInInteractableMock class used for testing.
class LoggedInInteractableMock: LoggedInInteractable,
                                LoggedInActionableItem {
    
    // Variables
    var router: LoggedInRouting? { didSet { routerSetCallCount += 1 } }
    var routerSetCallCount = 0
    var listener: LoggedInListener? { didSet { listenerSetCallCount += 1 } }
    var listenerSetCallCount = 0
    var isActive: Bool = false { didSet { isActiveSetCallCount += 1 } }
    var isActiveSetCallCount = 0
    var isActiveStreamSubject: PublishSubject<Bool> = PublishSubject<Bool>() { didSet { isActiveStreamSubjectSetCallCount += 1 } }
    var isActiveStreamSubjectSetCallCount = 0
    var isActiveStream: Observable<Bool> { return isActiveStreamSubject }

    // Function Handlers
    var activateHandler: (() -> ())?
    var activateCallCount: Int = 0
    var deactivateHandler: (() -> ())?
    var deactivateCallCount: Int = 0
    var startTicTacToeHandler: (() -> ())?
    var startTicTacToeCallCount: Int = 0
    var gameDidEndHandler: (() -> ())?
    var gameDidEndCallCount: Int = 0
    var launchGameCallCount: Int = 0
    var launchGameHandler: ((_ id: String?) -> Observable<(LoggedInActionableItem, ())>)?

    init() {
    }

    func activate() {
        activateCallCount += 1
        if let activateHandler = activateHandler {
            return activateHandler()
        }
    }

    func deactivate() {
        deactivateCallCount += 1
        if let deactivateHandler = deactivateHandler {
            return deactivateHandler()
        }
    }
    
    func launchGame(with id: String?) -> RxSwift.Observable<(TicTacToe.LoggedInActionableItem, ())> {
        launchGameCallCount += 1
        if let launchGameHandler {
            return launchGameHandler(id)
        }
        fatalError("Function build returns a value that can't be handled with a default value and its handler must be set")
    }

    func startTicTacToe() {
        startTicTacToeCallCount += 1
        if let startTicTacToeHandler = startTicTacToeHandler {
            return startTicTacToeHandler()
        }
    }

    
    func gameDidEnd(with winner: TicTacToe.PlayerKind) {
        gameDidEndCallCount += 1
        if let gameDidEndHandler = gameDidEndHandler {
            return gameDidEndHandler()
        }
    }
}

// MARK: - LoggedInRoutingMock class

/// A LoggedInRoutingMock class used for testing.
class LoggedInRoutingMock: LoggedInRouting {
    // Variables
    var interactable: Interactable { didSet { interactableSetCallCount += 1 } }
    var interactableSetCallCount = 0
    var children: [Routing] = [Routing]() { didSet { childrenSetCallCount += 1 } }
    var childrenSetCallCount = 0
    var lifecycleSubject: PublishSubject<RouterLifecycle> = PublishSubject<RouterLifecycle>() { didSet { lifecycleSubjectSetCallCount += 1 } }
    var lifecycleSubjectSetCallCount = 0
    var lifecycle: Observable<RouterLifecycle> { return lifecycleSubject }

    // Function Handlers
    var cleanupViewsHandler: (() -> ())?
    var cleanupViewsCallCount: Int = 0
    var routeToTicTacToeHandler: (() -> ())?
    var routeToTicTacToeCallCount: Int = 0
    var routeToOffGameHandler: (() -> ())?
    var routeToOffGameCallCount: Int = 0
    var loadHandler: (() -> ())?
    var loadCallCount: Int = 0
    var attachChildHandler: ((_ child: Routing) -> ())?
    var attachChildCallCount: Int = 0
    var detachChildHandler: ((_ child: Routing) -> ())?
    var detachChildCallCount: Int = 0

    init(interactable: Interactable) {
        self.interactable = interactable
    }

    func cleanupViews() {
        cleanupViewsCallCount += 1
        if let cleanupViewsHandler = cleanupViewsHandler {
            return cleanupViewsHandler()
        }
    }

    func routeToTicTacToe() {
        routeToTicTacToeCallCount += 1
        if let routeToTicTacToeHandler = routeToTicTacToeHandler {
            return routeToTicTacToeHandler()
        }
    }

    func routeToOffGame() {
        routeToOffGameCallCount += 1
        if let routeToOffGameHandler = routeToOffGameHandler {
            return routeToOffGameHandler()
        }
    }

    func load() {
        loadCallCount += 1
        if let loadHandler = loadHandler {
            return loadHandler()
        }
    }

    func attachChild(_ child: Routing) {
        attachChildCallCount += 1
        if let attachChildHandler = attachChildHandler {
            return attachChildHandler(child)
        }
    }

    func detachChild(_ child: Routing) {
        detachChildCallCount += 1
        if let detachChildHandler = detachChildHandler {
            return detachChildHandler(child)
        }
    }
}

// MARK: - LoggedOutBuildableMock class

/// A LoggedOutBuildableMock class used for testing.
class LoggedOutBuildableMock: LoggedOutBuildable {

    // Function Handlers
    var buildHandler: ((_ listener: LoggedOutListener) -> LoggedOutRouting)?
    var buildCallCount: Int = 0

    init() {
    }

    func build(withListener listener: LoggedOutListener) -> LoggedOutRouting {
        buildCallCount += 1
        if let buildHandler = buildHandler {
            return buildHandler(listener)
        }
        fatalError("Function build returns a value that can't be handled with a default value and its handler must be set")
    }
}

// MARK: - RootInteractableMock class

/// A RootInteractableMock class used for testing.
class RootInteractableMock: RootInteractable {
    // Variables
    var router: RootRouting? { didSet { routerSetCallCount += 1 } }
    var routerSetCallCount = 0
    var listener: RootListener? { didSet { listenerSetCallCount += 1 } }
    var listenerSetCallCount = 0
    var isActive: Bool = false { didSet { isActiveSetCallCount += 1 } }
    var isActiveSetCallCount = 0
    var isActiveStreamSubject: PublishSubject<Bool> = PublishSubject<Bool>() { didSet { isActiveStreamSubjectSetCallCount += 1 } }
    var isActiveStreamSubjectSetCallCount = 0
    var isActiveStream: Observable<Bool> { return isActiveStreamSubject }

    // Function Handlers
    var activateHandler: (() -> ())?
    var activateCallCount: Int = 0
    var deactivateHandler: (() -> ())?
    var deactivateCallCount: Int = 0
    var didLoginHandler: ((_ player1Name: String, _ player2Name: String) -> ())?
    var didLoginCallCount: Int = 0

    init() {
    }

    func activate() {
        activateCallCount += 1
        if let activateHandler = activateHandler {
            return activateHandler()
        }
    }

    func deactivate() {
        deactivateCallCount += 1
        if let deactivateHandler = deactivateHandler {
            return deactivateHandler()
        }
    }

    func didLogin(withPlayer1Name player1Name: String, player2Name: String) {
        didLoginCallCount += 1
        if let didLoginHandler = didLoginHandler {
            return didLoginHandler(player1Name, player2Name)
        }
    }
}

// MARK: - RootViewControllableMock class

/// A RootViewControllableMock class used for testing.
class RootViewControllableMock: RootViewControllable {
    
    // Variables
    var uiviewController: UIViewController = UIViewController() { didSet { uiviewControllerSetCallCount += 1 } }
    var uiviewControllerSetCallCount = 0

    // Function Handlers
    var replaceModelHandler: ((_ viewController: ViewControllable?) -> ())?
    var replaceModalCallCount: Int = 0

    init() {
    }

    func replaceModal(viewController: RIBs.ViewControllable?) {
        replaceModalCallCount += 1
        if let replaceModelHandler {
            return replaceModelHandler(viewController)
        }
    }
}
