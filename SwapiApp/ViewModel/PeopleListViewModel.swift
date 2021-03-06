//
//  PeopleListViewModel.swift
//  SwapiApp
//
//  Created by Atul Prakash on 17/09/2020.
//  Copyright © 2020 Atul Prakash. All rights reserved.
//

import Foundation
import Combine

final class PeopleListViewModel: ObservableObject, Identifiable {
	
	@Published var peoples: [People] = []
	@Published var loading = false
	
	private let dataService: SwapiService
	
	private var disposables = Set<AnyCancellable>()
	
	init(dataService: SwapiService) {
		self.dataService = dataService
	}
	
	func loadPeoples() {
		self.loading = true
		dataService.allPeople(page: nil)
			.map { response in
				response.results
					.sorted(by: { people1, people2 in
						people1.name < people2.name
					})
		}
		.receive(on: DispatchQueue.main)
		.sink(receiveCompletion: { completion in
			switch completion {
				case .failure(let error):
					self.loading = false
					print("There was an error: \(error)")
					self.peoples = []
				case .finished:
					self.loading = false
					break
			}
		}, receiveValue: { peoples in
			self.loading = false
			self.peoples = peoples
		})
			.store(in: &disposables)
	}
	
	func peopleView(forPeople people: People) -> PeopleView {
		let service = PeopleService(people: people)
		let vm = PeopleViewModel(graphService: service)
		return PeopleView(viewModel: vm)
	}
}
