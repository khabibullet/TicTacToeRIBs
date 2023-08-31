//
//  SceneDelegate.swift
//  TicTacToe
//
//  Created by Irek Khabibullin on 25.08.2023.
//  Copyright © 2023 Uber. All rights reserved.
//

import RIBs
import UIKit

protocol UrlHandler: AnyObject {
    func handle(_ url: URL)
}

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    private var launchRouter: LaunchRouting?
    
    private var urlHandler: UrlHandler?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = scene as? UIWindowScene else { return }

        let window = UIWindow(windowScene: windowScene)
        self.window = window

        let (launchRouter, urlHandler) = RootBuilder(dependency: AppComponent()).build()
        self.launchRouter = launchRouter
        self.urlHandler = urlHandler
        
        launchRouter.launchFromWindow(window)
        
        if let url = connectionOptions.urlContexts.first?.url {
            self.urlHandler?.handle(url)
        }
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        if let url = URLContexts.first?.url {
            urlHandler?.handle(url)
        }
    }
    
}

