//
//  BindingService.swift
//  SwapiApp
//
//  Created by Atul Prakash on 17/09/2020.
//  Copyright © 2020 Atul Prakash. All rights reserved.
//

import Foundation
import Combine

protocol BindingService {
	
	/// Call this function to update the associated properties handled by the `GraphService`.
	func fetchAssociatedProperties()
	
	func handleError(_ error: ServiceError)
	
}

extension BindingService {
	
	func handleError(_ error: ServiceError) {
		print("There was an error: \(error)")
	}
	
}

/// A free function for getting multiple `Person` resources from an array of resource URLs.
/// - Parameter dataService: A data service, conforming to `SwapiService`.
/// - Parameter urls: The specified array of `String` URLs.
/// - Parameter receiveCompletion: A closure executed upon completion of the request.
/// - Parameter receiveValue: A closure executed upon receipt of the value, takes an array of `Person` as it's argument.
/// - Returns: A cancellable instance.
func fetchPeople(
	from dataService: SwapiService,
	with urls: [String],
	receiveCompletion: @escaping ((Subscribers.Completion<ServiceError>) -> Void),
	receiveValue: @escaping (([People]) -> Void)
) -> AnyCancellable {
	return dataService.people(fromResourceUrls: urls)
		.receive(on: DispatchQueue.main)
		.sink(receiveCompletion: receiveCompletion, receiveValue: receiveValue)
}

/// A free function for getting multiple `Film` resources from an array of resource URLs
/// - Parameters:
///   - dataService: A data service, conforming to `SwapiService`.
///   - urls: The specified array of `String` URLs.
///   - receiveCompletion: A closure to execute upon completion of the request.
///   - receiveValue: A closure for execution upon receipt of the value, takes an array of `Film` as its argument.
/// - Returns: A cancellable instance.
func fetchFilms(
	from dataService: SwapiService,
	with urls: [String],
	receiveCompletion: @escaping ((Subscribers.Completion<ServiceError>) -> Void),
	receiveValue: @escaping (([Film]) -> Void)
) -> AnyCancellable {
	return dataService.films(fromResourceUrls: urls)
		.receive(on: DispatchQueue.main)
		.sink(receiveCompletion: receiveCompletion, receiveValue: receiveValue)
}

