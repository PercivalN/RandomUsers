//
//  User.swift
//  RandomUsers
//
//  Created by Percy Ngan on 9/6/19.
//  Copyright © 2019 Lamdba School. All rights reserved.
//

import Foundation

// Decodable is for get only
// Codable has Encodable and Decodable inside of it. Decodable takes information and puts it into a swift/Objective-C format
// Encodable takes Swift/Objective-C code and converts it into JSON
// First thing to do in a model is a struct
// Look at the resutls that are return by the ISP and see what type of data is on there
struct UserResults: Decodable {

	let results: [User]
}

struct User: Decodable {
	let name: String
}


