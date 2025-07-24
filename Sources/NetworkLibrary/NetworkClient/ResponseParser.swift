//
//  ResponseParser.swift
//  NetworkLibrary
//
//  Created by Siddhant Ranjan on 18/07/25.
//

import Foundation

protocol ResponseParserProtocol: Sendable, AnyObject {
    func parseResponse<T: Response>(_ data: Data, tClass: T.Type, completion: @Sendable @escaping (Result<T, APIError>) -> Void)
}

final class ResponseParser: ResponseParserProtocol {
    private let decoder: JSONDecoder
    
    init(decoder: JSONDecoder) {
        self.decoder = decoder
    }
    
    func parseResponse<T: Response>(_ data: Data, tClass: T.Type, completion: @Sendable @escaping (Result<T, APIError>) -> Void) {
        if let decodedData = try? decoder.decode(tClass, from: data) {
            completion(.success(decodedData))
            return
        }
        completion(.failure(APIError.decodingFailed))
    }
}
