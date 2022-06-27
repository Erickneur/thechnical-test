//
//  RestClientConfiguration.swift
//  Technical test
//
//  Created by Erick Dávila on 6/27/22.
//

struct ClientConfiguration {
    let baseURL: String
    let httpHeaders: [String: String]
    
    public init(baseURL: String, httpHeaders: [String: String]) {
        self.baseURL = baseURL
        self.httpHeaders = httpHeaders
    }
}

enum NetworkError: Error {
    case apiError(Int, error: Decodable)
    case invalidRequestError(String)
    case invalidResponse
    case parsingError(Error, String)
    case unauthorized
    case unexpectedError(Error)
}

struct Endpoint {
    let method: HTTPMethod
    let route: String
}

enum HTTPMethod: String {
    case GET
    case POST
    case PUT
    case DELETE
}
