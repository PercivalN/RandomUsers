//
//  UserDetailViewController.swift
//  RandomUsers
//
//  Created by Percy Ngan on 9/5/19.
//  Copyright © 2019 Lamdba School. All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController {


	@IBOutlet weak var emaillabel: UILabel!
	@IBOutlet weak var phoneLabel: UILabel!


	var user: User? {
		// This didSet checks to see if the user sent from the UserTableViewController is ready received
		didSet {
			// We will call the updateViews everytime we get new user info that didSet checks for us
			updateViews()
		}
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		updateViews()

	}
	
	func updateViews() {
		// Unwrap the user to make sure there is a user
		guard isViewLoaded,
			let user = user else { return }
		// Set the user name to be the title of the User Detail View
		title = user.name.first.capitalized + " " + user.name.last.capitalized
		emaillabel.text = user.email
		phoneLabel.text = user.phone
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
