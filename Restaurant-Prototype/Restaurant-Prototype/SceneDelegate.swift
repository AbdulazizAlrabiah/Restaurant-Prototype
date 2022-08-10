//
//  SceneDelegate.swift
//  Restaurant-Prototype
//
//  Created by Abdulaziz on 05/08/2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        
        #if COLLECTION_VIEW
        let vc = MainDependencyProvider.getMainCollectionScreen
        #else
        let vc = MainDependencyProvider.getMainScreen
        #endif
        
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
    }
}

