//
//  AuthEndpoint.swift
//  rurouni-fitness
//
//  Created by  Антон Штрамвасов on 31.03.2026.
//


import Foundation

class APIClient {
    static let shared = APIClient()
    private let session = URLSession.shared
    
    private init() {}
    
    // Основной метод запроса
    func request<T: Decodable>(_ endpoint: APIEndpoint) async throws -> T {
        let request = try endpoint.makeRequest()
        
        do {
            let (data, response) = try await session.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.unknown
            }
            
            switch httpResponse.statusCode {
            case 200...299:
                do {
                    let decoded = try JSONDecoder().decode(T.self, from: data)
                    return decoded
                } catch {
                    print("❌ Decoding error: \(error)")
                    print("📦 Raw data: \(String(data: data, encoding: .utf8) ?? "nil")")
                    throw NetworkError.decodingError
                }
            default:
                let message = String(data: data, encoding: .utf8)
                throw NetworkError.serverError(statusCode: httpResponse.statusCode, message: message)
            }
        } catch {
            throw error
        }
    }
    
    // Метод для запросов без ответа
    func request(_ endpoint: APIEndpoint) async throws {
        let _: EmptyResponse? = try await request(endpoint)
        return
    }
}

struct EmptyResponse: Decodable {}
