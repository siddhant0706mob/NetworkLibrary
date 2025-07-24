//
//  NetworkClient.swift
//  NetworkLibrary
//
//  Created by Siddhant Ranjan on 22/07/25.
//

import Foundation

class NetworkClient: NetworkClientProtocol {
   
    private let requestCaller: RequestCallerProtocol
    
    private let parser: ResponseParserProtocol
    
    private let requestBuilder: RequestBuilderProtocol
    
    private let decoder: ResponseParserProtocol
    
    init(requestCaller: RequestCallerProtocol,
         parser: ResponseParserProtocol,
         builder: RequestBuilderProtocol,
         decoder: ResponseParserProtocol) {
        self.requestCaller = requestCaller
        self.parser = parser
        self.requestBuilder = builder
        self.decoder = decoder
    }
    
    func request<T: Response>(_ request: Request, completion: @Sendable @escaping (Result<T, APIError>) -> Void) {
        guard let urlRequest = requestBuilder.buildRequest(from: request) else {
            completion(.failure(.invalidURL))
            return
        }
        requestCaller.request(urlRequest) { data, response, error in
            if let error {
                completion(.failure(.custom(error)))
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data else {
                completion(.failure(.noData))
                return
            }
            
            if (200...299).contains(response.statusCode) {
                decoder.parseResponse(data, completion: { result in  
                    switch result {
                    case .failure(let error):
                        completion(result)
                    case .success(let value):
                        completion(.success(value))
                    }
                })
            }
        }
    }
}
