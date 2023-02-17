//
//  NetworkError.swift
//  pre_onboarding
//
//  Created by 홍성준 on 2023/02/17.
//

import Foundation

enum NetworkError {
    
    case badRequest
    case unauthorized
    case forbidden
    case notFound
    
    case internalServerError
    case badGateway
    
    // Custom Error
    
    case invalidRequest
    case responseError
    case decodeError
    case invalidData
    
    var error: Error {
        switch self {
        case .badRequest:               return CustomError(code: 400, message: "Bad Request")
        case .unauthorized:             return CustomError(code: 401, message: "Unauthorized")
        case .forbidden:                return CustomError(code: 403, message: "Forbidden")
        case .notFound:                 return CustomError(code: 404, message: "Not Found")
            
        case .internalServerError:      return CustomError(code: 500, message: "Internal Server Error")
        case .badGateway:               return CustomError(code: 501, message: "Bad Gateway")
            
        case .invalidRequest:           return CustomError(code: -1, message: "Invalid Request")
        case .responseError:            return CustomError(code: -2, message: "Network Response Error")
        case .decodeError:              return CustomError(code: -3, message: "Invalid Response Type. Decode Error")
        case .invalidData:              return CustomError(code: -4, message: "Invalid Data")
        }
    }
    
}

struct CustomError: Error {
    
    var code: Int
    var message: String
    
}
