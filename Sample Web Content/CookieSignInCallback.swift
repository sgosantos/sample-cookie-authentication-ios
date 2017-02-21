//
//  CookieSignInCallback.swift
//  Sample Web Content
//
//  Created by Silvio Gustavo de O. Santos on 2/13/17.
//  Copyright © 2017 Liferay. All rights reserved.
//

import Foundation
import LRMobileSDK

class CookieSignInCallback : NSObject, LRCookieCallback {

	weak var viewController: WebViewController?

	init(viewController: WebViewController) {
		self.viewController = viewController
	}

	func onSuccess(_ session: LRSession) {
		viewController?.didSignIn()
	}
	
	func onFailure(_ error: Error) {
		print("failure \(error.localizedDescription)")
	}
}
