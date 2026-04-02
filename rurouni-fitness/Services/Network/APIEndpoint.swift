//
//  APIEndpoint.swift
//  rurouni-fitness
//
//  Created by  Антон Штрамвасов on 31.03.2026.
//

import Foundation

protocol APIEndpoint {
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var body: Encodable? { get }
    var queryItems: [URLQueryItem]? { get }
}

extension APIEndpoint {
    var baseURL: String {
        Config.baseURL
    }
    
    var headers: [String: String]? {
        ["Content-Type": "application/json"]
    }
    
    var body: Encodable? { nil }
    var queryItems: [URLQueryItem]? { nil }
    
    func makeRequest() throws -> URLRequest {
        var components = URLComponents(string: baseURL + path)
        components?.queryItems = queryItems
        
        let urlString = baseURL + path
            print("🌍 URL: \(urlString)")
            
        
        guard let url = components?.url else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        // Добавляем заголовки
        headers?.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        // Добавляем тело запроса
        if let body = body {
            request.httpBody = try JSONEncoder().encode(body)
        }
        
        return request
    }
}
