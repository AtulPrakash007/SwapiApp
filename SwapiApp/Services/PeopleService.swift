//
//  PeopleService.swift
//  SwapiApp
//
//  Created by Atul Prakash on 17/09/2020.
//  Copyright © 2020 Atul Prakash. All rights reserved.
//

import Foundation
import Combine

final class PeopleService: BindingService, ObservableObject {
	let people: People
	
	@Published public var films: [Film] = []
	
	private let dataService: SwapiService
	
	private var disposables = Set<AnyCancellable>()
	
	/// Initializes a new instance of `PersonGraphService`.
	/// - Parameters:
	///   - person: The specified `Person`
	///   - dataService: A data service conforming to `SwapiService`. Defaults to `DataService` if not specified.
	init(
		people: People,
		dataService: SwapiService = DataService()
	) {
		self.people = people
		self.dataService = dataService
	}
	
	func fetchAssociatedProperties() {
		fetchFilms(
			from: dataService,
			with: people.films,
			receiveCompletion: { completion in
				switch completion {
					case .failure(let error):
						self.handleError(error)
						self.films = []
					case .finished:
						break
				}
		}, receiveValue: { films in
			self.films = films
		})
			.store(in: &disposables)
	}
}
