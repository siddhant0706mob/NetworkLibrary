//
//  Mockables.swift
//  NetworkLibrary
//
//  Created by Siddhant Ranjan on 19/07/25.
//

import Foundation

struct HTTPParamsMockable: HTTPParams {
    var key: String
    var value: String
}

struct RequestMockable: Request {
    var requestTimeout: TimeInterval?
    
    var body: Data?
    
    var methodType: MethodType
    
    var endpoint: String
    
    var headers: [any HTTPParams]
    
    var queryParams: [any HTTPParams]
    
    var isCacheable: Bool
    
    var cacheExpiryTime: Bool?
    
    var retryCount: Int
}
