//
//  DataFetcher.swift
//  SwapiApp
//
//  Created by Atul Prakash on 17/09/2020.
//  Copyright © 2020 Atul Prakash. All rights reserved.
//

import Foundation
import Combine

public enum NetworkError: Error {

  case apiError(reason: String)
  case badRequest
  case badResponse
  case networkError(from: URLError)
  case unknown

  fileprivate static func error(withCode code: Int) -> NetworkError {
    switch code {
    case 401:
      return .apiError(reason: "Unauthorized")
    case 403:
      return .apiError(reason: "Resource forbidden")
    case 404:
      return .apiError(reason: "Resource not found")
    case 405..<500:
      return .apiError(reason: "Client error")
    case 500..<600:
      return .apiError(reason: "Server error")
    default:
      return .unknown
    }
  }
}

struct DataFetcher {
  private let sharedSession = URLSession.shared

  /// Performs a network request for the specified `URL`.
  /// - Parameter url: The `URL` specifying the location of the network resource.
  /// - Returns: A type-erasing publisher with output type `Data` and failure type `NetworkError`.
  func fetch(_ url: URL?) -> AnyPublisher<Data, NetworkError> {
    guard let url = url else {
      return Fail(error: NetworkError.badRequest).eraseToAnyPublisher()
    }

    let request = URLRequest(url: url)
    return sharedSession.dataTaskPublisher(for: request)
      .tryMap { data, response in
        guard let httpResponse = response as? HTTPURLResponse else {
          throw NetworkError.badResponse
        }
        guard httpResponse.statusCode == 200 || httpResponse.statusCode == 300 else {
          throw NetworkError.error(withCode: httpResponse.statusCode)
        }

        return data
      }
    .mapError { error in
      if let networkError = error as? NetworkError {
        return networkError
      }
      if let urlError = error as? URLError {
        return NetworkError.networkError(from: urlError)
      }

      return NetworkError.unknown
    }
    .eraseToAnyPublisher()
  }
}
