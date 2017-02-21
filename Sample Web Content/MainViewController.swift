//
//  MainViewController.swift
//  Sample Web Content
//
//  Created by Silvio Gustavo de O. Santos on 2/21/17.
//  Copyright © 2017 Liferay. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

	init() {
		super.init(nibName: "MainViewController", bundle: nil)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	@IBAction func didTapOpenFileButton(_ sender: Any) {
		navigationController?.pushViewController(
			WebViewController(), animated: true)
	}
	
}

