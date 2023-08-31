//
//  RootRouterTests.swift
//  TicTacToeTest
//
//  Created by Irek Khabibullin on 29.08.2023.
//  Copyright © 2023 Uber. All rights reserved.
//

@testable import TicTacToe

import XCTest

class RootRouterTests: XCTestCase {

    private var loggedInBuilder: LoggedInBuildableMock!
    private var rootInteractor: RootInteractableMock!
    private var rootRouter: RootRouter!
    private var player1Name: String!
    private var player2Name: String!

    override func setUp() {
        super.setUp()

        loggedInBuilder = LoggedInBuildableMock()
        rootInteractor = RootInteractableMock()
        rootRouter = RootRouter(interactor: rootInteractor,
                   viewController: RootViewControllableMock(),
                   loggedOutBuilder: LoggedOutBuildableMock(),
                   loggedInBuilder: loggedInBuilder)
        player1Name = "Player1"
        player2Name = "Player2"
    }

    func test_routeToLoggedIn_verifyInvokeBuilderAttachReturnedRouter() {
        let loggedInRouter = LoggedInRoutingMock(interactable: LoggedInInteractableMock())
        let loggedInInteractor = LoggedInInteractableMock()
        var assignedListener: LoggedInListener? = nil
        loggedInBuilder.buildHandler = { (_ listener: LoggedInListener,
                                          _ player1Name: String,
                                          _ player2Name: String) -> (LoggedInRouting,
                                                                     LoggedInActionableItem) in
            assignedListener = listener
            return (loggedInRouter, loggedInInteractor)
        }

        XCTAssertNil(assignedListener)
        XCTAssertEqual(loggedInBuilder.buildCallCount, 0)
        XCTAssertEqual(loggedInRouter.loadCallCount, 0)

        let actionableItem = rootRouter.routeToLoggedIn(withPlayer1Name: "1", player2Name: "2")

        XCTAssertTrue(assignedListener === rootInteractor)
        XCTAssertEqual(loggedInBuilder.buildCallCount, 1)
        XCTAssertEqual(loggedInRouter.loadCallCount, 1)
    }
}
