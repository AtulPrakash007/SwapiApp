//
//  SwapiService.swift
//  SwapiApp
//
//  Created by Atul Prakash on 17/09/2020.
//  Copyright © 2020 Atul Prakash. All rights reserved.
//

import Foundation
import Combine

/// An enumeration of error states that can be returned from a `SwapiService`
enum ServiceError: Error {
	case unknown
	case networkError(error: NetworkError)
	case parsingError(error: Error)
}

/// Objects conforming to the `SwapiService` protocol may act as a data service for request resources from the Star Wars API (SWAPI)
protocol SwapiService {
	/// Call this function to request a `Person` resource with a resource ID.
	/// - Parameter resourceId: The specified ID `String` for the `Person` being requested.
	func person(withId resourceId: String) -> AnyPublisher<People, ServiceError>
	
	/// Call this function to request a list of all the `Person` resources available from the API service.
	/// - Parameter page: An optional resource URL `String` specifying the page of results being requested.
	func allPeople(page: String?) -> AnyPublisher<RootResult<People>, ServiceError>
	
	/// Call this function to perform multiple requests for `Person` resources using an array of resource URLs.
	/// - Parameter urls: The specified array of resource URLs for the resources being requested.
	func people(fromResourceUrls urls: [String]) -> AnyPublisher<[People], ServiceError>
	
	/// Call this function to perform multiple requests for `Film` resources using an array of resource URLs.
	/// - Parameter urls: The specified array of resource URLs for the resources being requested.
	func films(fromResourceUrls urls: [String]) -> AnyPublisher<[Film], ServiceError>
}

/// The default implementation of a data service conforming to the `SwapiService` protocol.
struct DataService: SwapiService {
	let dataFetcher = DataFetcher()
	
	init() { }
	
	func person(withId resourceId: String) -> AnyPublisher<People, ServiceError> {
		let config = RequestConfiguration(resource: .people)
		return resource(request: Request(config: config, resourceId: resourceId))
	}
	
	func film(withId resourceId: String) -> AnyPublisher<Film, ServiceError> {
		let config = RequestConfiguration(resource: .films)
		return resource(request: Request(config: config, resourceId: resourceId))
	}
	
	func allPeople(page: String?) -> AnyPublisher<RootResult<People>, ServiceError> {
		guard let pageUrl = page else {
			let config = RequestConfiguration(resource: .people)
			return resource(request: Request(config: config))
		}
		return resource(request: Request(resourceUrl: pageUrl))
	}
	
	func allFilms(page: String?) -> AnyPublisher<RootResult<Film>, ServiceError> {
		guard let pageUrl = page else {
			let config = RequestConfiguration(resource: .films)
			return resource(request: Request(config: config))
		}
		return resource(request: Request(resourceUrl: pageUrl))
	}
	
	func people(fromResourceUrls urls: [String]) -> AnyPublisher<[People], ServiceError> {
		let requests = urls.map { Request(resourceUrl: $0) }
		return resources(requests: requests)
	}
	
	func films(fromResourceUrls urls: [String]) -> AnyPublisher<[Film], ServiceError> {
		return resources(requests: urls.map { Request(resourceUrl: $0) })
	}
	
	func resources<T: RootData>(requests: [Request]) -> AnyPublisher<[T], ServiceError> {
		let masterPublisher = Publishers.Sequence<[AnyPublisher<T, ServiceError>], ServiceError>(
			sequence: requests.map(resource(request:))
		)
		return masterPublisher.flatMap { $0 }.collect().eraseToAnyPublisher()
	}
	
	func resource<T: RootData>(request: Request) -> AnyPublisher<T, ServiceError> {
		return dataFetcher.fetch(request.url)
			.mapError { error in
				ServiceError.networkError(error: error)
		}
		.flatMap(maxPublishers: .max(1)) { data in
			decode(data)
		}
		.eraseToAnyPublisher()
	}
}
