//
//  AppDelegate.swift
//  TempoTask
//
//  Created by Nour Hegazy on 26/06/2021.
//

import UIKit
import Moya
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        _ = NetworkReachabilityManger.sharedInstance
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
       let newsViewModel = NewsListViewModel(api: MoyaProvider<NewsApi>())
        let viewController = storyboard.instantiateViewController(withIdentifier :"NewsListViewController") as! NewsListViewController
        viewController.viewModel = newsViewModel
        let navController = UINavigationController.init(rootViewController: viewController)
        navController.navigationBar.isHidden = true
           if let window = self.window, let rootViewController = window.rootViewController {
               var currentController = rootViewController
               while let presentedController = currentController.presentedViewController {
                   currentController = presentedController
                }
                   currentController.present(navController, animated: true, completion: nil)
           }
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

