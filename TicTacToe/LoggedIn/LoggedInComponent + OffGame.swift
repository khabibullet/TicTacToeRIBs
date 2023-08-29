//
//  LoggedInComponent + OffGame.swift
//  TicTacToe
//
//  Created by Irek Khabibullin on 29.08.2023.
//  Copyright © 2023 Uber. All rights reserved.
//

import RIBs

/// The dependencies needed from the parent scope of LoggedIn to provide for the OffGame scope.
// TODO: Update LoggedInDependency protocol to inherit this protocol.
protocol LoggedInDependencyOffGame: Dependency {

    // TODO: Declare dependencies needed from the parent scope of LoggedIn to provide dependencies
    // for the OffGame scope.
}

extension LoggedInComponent: OffGameDependency {
    // TODO: Implement properties to provide for OffGame scope.
    var scoreStream: ScoreStream {
        return mutableScoreStream
    }
}
