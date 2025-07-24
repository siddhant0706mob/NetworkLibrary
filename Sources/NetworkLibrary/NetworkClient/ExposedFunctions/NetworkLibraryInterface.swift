import Foundation

public protocol NetworkClientProtocol {
    func request<T: Response>(_ request: Request, completion: @Sendable @escaping (Result<T, APIError>) -> Void)
}

public enum APIError: Error {
    case invalidURL
    case invalidResponse
    case decodingFailed
    case noData
    case custom(Error)
    case errorWithStatusCode(Int)
}

public enum MethodType: String {
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

public protocol HTTPParams {
    var key: String { get }
    var value: String { get }
}

public protocol Request {
    var methodType: MethodType { get }
    
    var endpoint: String { get }
    
    var requestTimeout: TimeInterval { get }
    
    var headers: [HTTPParams] { get }
    
    var queryParams: [HTTPParams] { get }
    
    var isCacheable: Bool { get }
    
    var cacheExpiryTime: Bool? { get }
    
    var retryCount: Int { get }
    
    var body: Data { get }
}

public protocol Response: Decodable { }
