//
//  AppDelegate.swift
//  Stocks
//
//  Created by Madi Keshilbayev on 23.05.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
	
	var window: UIWindow?
	
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		
		let window = UIWindow(frame: UIScreen.main.bounds)
		window.rootViewController = Assembly.assembler.tabBarController()
		window.makeKeyAndVisible()
		
		self.window = window
		
		return true
	}
}

