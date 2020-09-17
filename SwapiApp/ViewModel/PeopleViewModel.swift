//
//  PeopleViewModel.swift
//  SwapiApp
//
//  Created by Atul Prakash on 17/09/2020.
//  Copyright © 2020 Atul Prakash. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

final class PeopleViewModel: ObservableObject {
	
	@ObservedObject private var peopleService: PeopleService
	
	private var disposables = Set<AnyCancellable>()
	
	@Published var films: [Film] = []
	
	private var people: People {
		peopleService.people
	}
	
	init(graphService: PeopleService) {
		self.peopleService = graphService
	}
	
	func fetchProperties() {
		
		peopleService.fetchAssociatedProperties()
		
		peopleService
			.$films
			.receive(on: DispatchQueue.main)
			.sink { films in
				self.films = films.sorted(by: { (film1, film2) -> Bool in
					film1.episodeId < film2.episodeId
				})
		}
		.store(in: &disposables)
	}
	
	var name: String {
		people.name
	}
	
	var birthYear: String {
		people.birthYear
	}
	
	var gender: String {
		people.gender.capitalized
	}
	
	var height: String {
		"\(heightMeters) m"
	}
	
	var mass: String {
		"\(people.mass) kg"
	}
	
	var hair: String {
		"\(people.hairColor) hair"
	}
	
	var eyes: String {
		"\(people.eyeColor) eyes"
	}
	
	var skin: String {
		"\(people.skinColor) skin"
	}
	
	func filmRowView(for film: Film) -> FilmRowView {
		let vm = FilmRowViewModel(film: film)
		return FilmRowView(viewModel: vm)
	}
	
	private var heightMeters: String {
		let heightValue = Float(people.height) ?? 0
		return String(heightValue / 100)
	}
}

