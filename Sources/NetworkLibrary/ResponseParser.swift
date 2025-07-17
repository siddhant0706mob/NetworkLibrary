//
//  ResponseParser.swift
//  NetworkLibrary
//
//  Created by Siddhant Ranjan on 18/07/25.
//

import Foundation

protocol ResponseParserProtocol: Sendable, AnyObject {
    func parseResponse<T: Decodable>(_ data: Data, completion: @Sendable @escaping (Result<T, APIError>) -> Void)
}

final class ResponseParser: ResponseParserProtocol {
    private let decoder: JSONDecoder
    
    init(decoder: JSONDecoder) {
        self.decoder = decoder
    }
    
    func parseResponse<T: Decodable>(_ data: Data, completion: @Sendable @escaping (Result<T, APIError>) -> Void) {
        if let decodedData = try? decoder.decode(T.self, from: data) {
            completion(.success(decodedData))
            return
        }
        completion(.failure(APIError.decodingFailed))
    }
}
