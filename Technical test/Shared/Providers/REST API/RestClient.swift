//
//  RestClient.swift
//  Technical test
//
//  Created by Erick Dávila on 6/27/22.
//

import Combine
import Foundation

class RestClient {
    private let baseURL: String
    private let headers: [String: String]
    
    init() {
        baseURL = "https://jsonplaceholder.typicode.com/"
        headers = [:]
    }

    init(configuration: ClientConfiguration) {
        baseURL = configuration.baseURL
        headers = configuration.httpHeaders
    }
    
    func request<T: Decodable, U :Decodable>(
        endpoint: Endpoint,
        parameters: [String: Any]? = nil,
        headers: [String: String]? = nil,
        type: T.Type,
        errorType: U.Type
    ) -> AnyPublisher<T, Error> {
        let fullURLString = baseURL + endpoint.route
        
        guard let url = URL(string: fullURLString) else {
            return Fail(
                error: NetworkError.invalidRequestError(
                    "Invalid URL: \(fullURLString)")
            )
            .eraseToAnyPublisher()
        }
        
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = endpoint.method.rawValue
        
        self.headers.forEach { (key, value) in
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }
        
        if endpoint.method != .GET,
         let parameters = parameters {
            urlRequest.httpBody = try? JSONSerialization.data(
                withJSONObject: parameters,
                options: .prettyPrinted
            )
        }
        
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .mapError({ error -> NetworkError in
                .unexpectedError(error)
            })
            .tryMap({ (data, response) -> (data: Data, response: URLResponse) in
                guard let urlResponse = response as? HTTPURLResponse else {
                    throw NetworkError.invalidResponse
                }
                switch urlResponse.statusCode {
                case 401:
                    throw NetworkError.unauthorized
                case 400, 402...599:
                    let decoder = JSONDecoder()
                    let apiError = try decoder.decode(errorType, from: data)
                    throw NetworkError.apiError(urlResponse.statusCode, error: apiError)
                default:
                    break
                }
                return (data, response)
            })
            .map(\.data)
            .tryMap({ data -> T in
                let decoder = JSONDecoder()
                do {
                    return try decoder.decode(T.self, from: data)
                } catch {
                    let message = "Failed parsing object: \(String(describing: T.self))"
                    throw NetworkError.parsingError(error, message)
                }
            })
            .eraseToAnyPublisher()
    }
}
