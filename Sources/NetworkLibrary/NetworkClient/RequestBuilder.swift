//
//  RequestBuilder.swift
//  NetworkLibrary
//
//  Created by Siddhant Ranjan on 15/07/25.
//

import Foundation

protocol RequestBuilderProtocol: Sendable,
                                 AnyObject {
    func buildRequest(from request: Request) -> URLRequest?
}

class RequestBuilder {
    
    func buildRequest(from request: Request) -> URLRequest? {
        guard var urlComponent = URLComponents(string: request.endpoint) else { return nil }
        
        var queryItems = [URLQueryItem]()
        
        request.queryParams.forEach { param in
            queryItems.append(URLQueryItem(name: param.key, value: param.value))
        }
        
        if !queryItems.isEmpty {
            urlComponent.queryItems = queryItems
        }
        
        guard let url = urlComponent.url else { return nil }
        
        var urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: request.requestTimeout)
        
        urlRequest.httpMethod = request.methodType.rawValue
        urlRequest.httpBody = request.body
        
        request.headers.forEach { header in
            urlRequest.setValue(header.value, forHTTPHeaderField: header.key)
        }
        return urlRequest
    }
}
