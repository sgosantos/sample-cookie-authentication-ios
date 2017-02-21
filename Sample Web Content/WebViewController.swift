//
//  WebViewController.swift
//  Sample Web Content
//
//  Created by Silvio Gustavo de O. Santos on 2/13/17.
//  Copyright © 2017 Liferay. All rights reserved.
//

import LRMobileSDK
import UIKit

class WebViewController: UIViewController {

	@IBOutlet var webView: UIWebView!

	override func viewDidLoad() {
		super.viewDidLoad()

		let auth = LRBasicAuthentication(username: "test@liferay.com", password: "test")
		let session = LRSession(server: "http://localhost:8080", authentication: auth)
		let callback = CookieSignInCallback(viewController: self)

		LRCookieSignIn.signIn(with: session, callback: callback)
	}

	func didSignIn() {
		let url = URL(string: "http://localhost:8080/documents/20181/0/boardingPass.pdf/1a4d41b9-75b6-6408-6f78-b00d33012d03")!

		download(url: url)
	}

	/*
     * Download a file and open after the download completes
     */
	fileprivate func download(url: URL) {
		let urlRequest = NSMutableURLRequest(url: url)
		let session = URLSession(configuration: .default)

		session.downloadTask(
			with: urlRequest as URLRequest,
			completionHandler:{ [weak self] localURL, response, error in
				if let error = error {
					//check for errors
				}
				else if let localURL = localURL {
					let fileExtension = self?.getFileExtension(response) ?? ".tmp"

					do {
						let localCacheURL = try self?.moveTmpToCache(
							localURL.absoluteString,
							fileExtension: fileExtension)

						if let localCacheURL = localCacheURL {
							self?.openFile(url: localCacheURL)
						}
					}
					catch _ {
						//error
					}
				}
				else {
					//error
				}
				
		}).resume()
	}

	/*
	 * Open a local or remote file in a webview
	 */
	fileprivate func openFile(url: URL) {
		webView.loadRequest(URLRequest(url: url))
	}

	fileprivate func cacheFilePath() -> String {
		let cache = NSSearchPathForDirectoriesInDomains(
			.cachesDirectory, .allDomainsMask, true)[0]

		var cachePath = ""

		repeat {
			cachePath = "\(cache)/\(UUID().uuidString)"
		}
		while (FileManager.default.fileExists(atPath: cachePath))

		return cachePath
	}

	fileprivate func moveTmpToCache(
		_ localPath: String, fileExtension: String) throws -> URL {

		let cachePath = cacheFilePath()
		let cachePathUrl = URL(fileURLWithPath: cachePath + "." + fileExtension)

		try FileManager.default.moveItem(
			at: URL(string: localPath)!,
			to: cachePathUrl)

		return cachePathUrl
	}

	fileprivate func getFileExtension(_ response: URLResponse?) -> String {
		if let ext = response?
			.suggestedFilename?
			.characters
			.split(separator: ".")
			.map(String.init).last {

			return ext
		}

		return "tmp"
	}

}

