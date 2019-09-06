//
//  APIController.swift
//  RandomUsers
//
//  Created by Percy Ngan on 9/6/19.
//  Copyright © 2019 Lamdba School. All rights reserved.
//

import Foundation

class APIController {

	var user: [User] = []

	// The reason we can use the bang operator here is because if the baseURL is wrong we want the app to crash
	let baseURL = URL(string: "https://randomuser.me/api/?format=json&results=20")!
	typealias CompletionHandler = (Error?) -> Void

	// we setup the completion; we use @escaping so that if we run into a snag we can escape out of the function
	func getUsers(completion: @escaping CompletionHandler = { _ in}) {
		// URLSession gets in contact with the api and accomplishes some data task for us
		// in is used like a curly brace, the following line says if you get the data, the response and the error then do this
		URLSession.shared.dataTask(with: baseURL) { (data, _, error) in
			// This checks to see if there is an error from the api
			if let error = error { // We are using if let and not a guard let because we don't we to use the error
				// NSLog provides more information then just the print statement
				NSLog("Error getting users: \(error)")
			}

			// This checks to see if we have data from the api
			// We are using guard let because we need the data if it is there
			guard let data = data else {
				NSLog("No data return from data task.") // We don't need to string interpolate the error because the message is explicit enough.
				completion(nil) // If we don't get data then we want to get out of this function which is why use completion
				return // We have to return because this is an else in the statement
			}
			do {
				// setting a newUser instance to use an instance of JSONDecoder and using the decode function to get the data from the api and put it into the UserResult model that we created
				let newUser = try JSONDecoder().decode(UserResult.self, from: data)
				print(newUser) // Use this print statement to troubleshoot if there is anything in newUser
				self.user = newUser.results // We are just putting the data from the api into the user variable declared at the top
			} catch {
				NSLog("Error decoding users: \(error)")
				completion(error)
			}
			completion(nil) // We have to do a completion everytime we finish a do statement
		}.resume() // This continues the dataTask as many times as it takes
		// TODO: Ask Mitch why the dataTask has to resume. Is it because it has to iterate until something happens
	}



}
