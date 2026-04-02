//
//  NetworkError.swift
//  rurouni-fitness
//
//  Created by  Антон Штрамвасов on 31.03.2026.
//

import Foundation

enum NetworkError: LocalizedError {
    case invalidURL
    case noData
    case decodingError
    case unauthorized
    case serverError(statusCode: Int, message: String?)
    case unknown
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Неверный URL"
        case .noData:
            return "Нет данных от сервера"
        case .decodingError:
            return "Ошибка обработки данных"
        case .unauthorized:
            return "Не авторизован. Войдите снова"
        case .serverError(let code, let message):
            return message ?? "Ошибка сервера (\(code))"
        case .unknown:
            return "Неизвестная ошибка"
        }
    }
}
