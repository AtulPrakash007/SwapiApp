//
//  Film.swift
//  SwapiApp
//
//  Created by Atul Prakash on 17/09/2020.
//  Copyright © 2020 Atul Prakash. All rights reserved.
//

import Foundation

struct Film: RootData, Equatable, Hashable {
	
	let title: String
	let episodeId: Int
	let openingCrawl: String
	let director: String
	let producer: String
	let releaseDate: String
	let characters: [String]
	let planets: [String]
	let starships: [String]
	let vehicles: [String]
	let species: [String]
	let created: Date
	let edited: Date
	let url: String
	
	enum CodingKeys: String, CodingKey {
		case title
		case episodeId = "episode_id"
		case openingCrawl = "opening_crawl"
		case director
		case producer
		case releaseDate = "release_date"
		case characters
		case planets
		case starships
		case vehicles
		case species
		case created
		case edited
		case url
	}
}
