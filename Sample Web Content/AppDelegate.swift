//
//  AppDelegate.swift
//  Sample Web Content
//
//  Created by Silvio Gustavo de O. Santos on 2/13/17.
//  Copyright © 2017 Liferay. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
		let navigationController = UINavigationController()

		window = UIWindow(frame: UIScreen.main.bounds)
		window!.rootViewController = navigationController
		window!.makeKeyAndVisible()

		navigationController.setViewControllers(
			[MainViewController()], animated: false)
		
		return true
	}

}

