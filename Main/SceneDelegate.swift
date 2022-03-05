//
//  SceneDelegate.swift
//  Main
//
//  Created by Wagner Coleta on 21/02/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let httpClient = makeAlamofireAdapter()
        let readActive = makeRemoteReadActive(httpClient: httpClient)
        window?.rootViewController = makeActiveController(readActive: readActive)
        window?.makeKeyAndVisible()
    }
}

