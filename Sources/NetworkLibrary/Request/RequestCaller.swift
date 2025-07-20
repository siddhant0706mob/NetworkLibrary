//
//  Untitled.swift
//  NetworkLibrary
//
//  Created by Siddhant Ranjan on 18/07/25.
//

import Foundation

protocol RequestCallerProtocol {
    func call<T: Decodable>(_ request: URLRequest, completion: @Sendable @escaping (Result<T, APIError>) -> Void)
}

final class RequestCaller: RequestCallerProtocol, Sendable {
    
    private let urlSession: URLSession
    
    private let parser: ResponseParserProtocol
    
    init(urlSession: URLSession = .shared, parser: ResponseParserProtocol) {
        self.urlSession = urlSession
        self.parser = parser
    }
    
    func call<T>(_ request: URLRequest, completion: @Sendable @escaping (Result<T, APIError>) -> Void) where T : Decodable {
        urlSession.dataTask(with: request, completionHandler: { [weak self] data, response, error in
            if let error {
                if let error = error as? APIError {
                    completion(.failure(error))
                } else {
                    completion(.failure(.custom(error)))
                }
            }
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.noData))
                return
            }
            
            guard let data else {
                completion(.failure(APIError.noData))
                return
            }
            
            if (200...299).contains(httpResponse.statusCode) {
                self?.parser.parseResponse(data, completion: completion)
            }
        }).resume()
    }
}
