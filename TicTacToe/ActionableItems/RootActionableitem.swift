//
//  RootActionableitem.swift
//  TicTacToe
//
//  Created by Irek Khabibullin on 30.08.2023.
//  Copyright © 2023 Uber. All rights reserved.
//

import RxSwift

public protocol RootActionableItem: AnyObject {
    func waitForLogin() -> Observable<(LoggedInActionableItem, ())>
}
