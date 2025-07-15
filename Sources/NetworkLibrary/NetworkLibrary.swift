// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

public enum MethodType {
    case GET
    case POST
    case PUT
    case PATCH
    case DELETE
    case OPTIONS
    case HEAD
    case CONNECT
    case TRACE
}

public protocol Request {
    
    var methodType: MethodType { get }
    
    var endpoint: String { get }
    
}
