//
//  UsersTableViewController.swift
//  RandomUsers
//
//  Created by Percy Ngan on 9/5/19.
//  Copyright © 2019 Lamdba School. All rights reserved.
//

import UIKit

class UsersTableViewController: UITableViewController {

	let apiController = APIController()

	override func viewDidLoad() {
		super.viewDidLoad()

		// We put this in the viewDidLoad because we want the network call to happen when the app starts
		apiController.getUsers { (error) in
			// let the user know if there is an error
			if let error = error {
				NSLog("Errro performing data task: \(error)")
			}
			// After the networking task is done we can put it back on the main thread/ the main Queue
			DispatchQueue.main.async {
				self.tableView.reloadData()
			}
		}

	}

	// MARK: - Table view data source

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

		return apiController.users.count
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath)
		// let a user be something inthe apiController in the users array, and it can be accessed via the indexPath row
		let user = apiController.users[indexPath.row]
		cell.textLabel?.text = user.name.first.capitalized + " " + user.name.last.capitalized // capitalized just capitalizes the first letter of the string in the cell
		guard let imageDate = try? Data(contentsOf: user.picture.large) else { fatalError() }
		cell.imageView?.image = UIImage(data: imageDate) // google url to uimage swift
		return cell
	}


	/*
	// Override to support conditional editing of the table view.
	override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
	// Return false if you do not want the specified item to be editable.
	return true
	}
	*/

	/*
	// Override to support editing the table view.
	override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
	if editingStyle == .delete {
	// Delete the row from the data source
	tableView.deleteRows(at: [indexPath], with: .fade)
	} else if editingStyle == .insert {
	// Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
	}
	}
	*/

	/*
	// Override to support rearranging the table view.
	override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

	}
	*/

	/*
	// Override to support conditional rearranging of the table view.
	override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
	// Return false if you do not want the item to be re-orderable.
	return true
	}
	*/


	// MARK: - Navigation

	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		// First we have to identify the segue
		if segue.identifier == "UserDetailSegue" {
			// Then we need to create the address that the user is passed to; Then need to create and unwrap the userDetailVC and cast it as UserDetailViewController and if it is not it then just return
			guard let userDetailVC = segue.destination as? UserDetailViewController else { return }
			// Now we need the specific spot, or the zipcode, in this case the indexPath, the user data is at; Now we have to create and unwrap the indexPath that is assigned the location in the tableView
			guard let indexPath = tableView.indexPathForSelectedRow else { return }
			// The thing that we are sending is the user and we are telling the segue the specific row that the user is on which is indexPath.row
			let user = apiController.users[indexPath.row]
			// We have to create an user object in the UserDetailViewController and pass the user to it
			userDetailVC.user = user
		}
	}

	

}
