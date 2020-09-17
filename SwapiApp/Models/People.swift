//
//  People.swift
//  SwapiApp
//
//  Created by Atul Prakash on 17/09/2020.
//  Copyright © 2020 Atul Prakash. All rights reserved.
//

import Foundation

struct People: RootData, Hashable {
	
	let name: String
	let height: String
	let mass: String
	let hairColor: String
	let skinColor: String
	let eyeColor: String
	let birthYear: String
	let gender: String
	let homeworld: String
	let films: [String]
	let species: [String]
	let vehicles: [String]
	let starships: [String]
	let created: Date
	let edited: Date
	let url: String
	
	enum CodingKeys: String, CodingKey {
		case name
		case height
		case mass
		case hairColor = "hair_color"
		case skinColor = "skin_color"
		case eyeColor = "eye_color"
		case birthYear = "birth_year"
		case gender
		case homeworld
		case films
		case species
		case vehicles
		case starships
		case created
		case edited
		case url
	}
}

