//
//  UserDetailViewController.swift
//  RandomUsers
//
//  Created by Percy Ngan on 9/5/19.
//  Copyright © 2019 Lamdba School. All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController {

	var user: User? {
		// This didSet checks to see if the user sent from the UserTableViewController is ready received
		didSet {
			// We will call the updateViews everytime we get new user info that didSet checks for us
			updateViews()
		}
	}

	override func viewDidLoad() {
		super.viewDidLoad()


	}

	func updateViews() {
		// Unwrap the user to make sure there is a user
		guard let user = user else { return }
		// Set the user name to be the title of the User Detail View
		title = user.name.first.capitalized
	}
	/*
	// MARK: - Navigation

	// In a storyboard-based application, you will often want to do a little preparation before navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
	// Get the new view controller using segue.destination.
	// Pass the selected object to the new view controller.
	}
	*/

}
