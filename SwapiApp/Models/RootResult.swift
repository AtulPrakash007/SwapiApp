//
//  RootResult.swift
//  SwapiApp
//
//  Created by Atul Prakash on 17/09/2020.
//  Copyright © 2020 Atul Prakash. All rights reserved.
//

import Foundation

typealias RootData = Codable

struct RootResult<T: RootData>: Codable {
	let count: Int
	let next: String?
	let previous: String?
	let results: [T]
}
