//
//  AuthInterceptor.swift
//  NetworkLibrary
//
//  Created by Siddhant Ranjan on 20/07/25.
//

import Foundation

protocol AuthInterceptorProtocol {
    func intercept(_ request: URLRequest)
    func refreshToken(with request: URLRequest)
}

class AuthInterceptor: AuthInterceptorProtocol {
    
    func intercept(_ request: URLRequest) {
        
    }
    
    func refreshToken() {
        
    }
}
