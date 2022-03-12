//
//  SceneDelegate.swift
//  Main
//
//  Created by Wagner Coleta on 21/02/22.
//

import UIKit
import UI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let nav = NavigationController()
        let httpClient = makeAlamofireAdapter()
        let readActive = makeRemoteReadActive(httpClient: httpClient)
        let activeController = makeActiveController(readActive: readActive)
        nav.setRootViewController(activeController)
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
    }
}

