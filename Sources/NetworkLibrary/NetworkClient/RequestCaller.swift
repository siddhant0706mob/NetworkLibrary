//
//  RequestCaller.swift
//  NetworkLibrary
//
//  Created by Siddhant Ranjan on 22/07/25.
//

import Foundation

protocol RequestCallerProtocol {
    func request(_ request: URLRequest, completion: @Sendable @escaping (Data?, URLResponse?, Error?) -> Void)
}

class RequestCaller: RequestCallerProtocol {
    
    private let session: URLSession
    
    init(session: URLSession) {
        self.session = session
    }
    
    func request(_ request: URLRequest, completion: @Sendable @escaping (Data?, URLResponse?, Error?) -> Void) {
        session.dataTask(with: request, completionHandler: { data, urlResponse, error in
            completion(data, urlResponse, error)
        }).resume()
    }
}
