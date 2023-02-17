//
//  DogAPI.swift
//  pre_onboarding
//
//  Created by 홍성준 on 2023/02/17.
//

import Foundation

enum DogAPI {
    
    case dog
    
}

extension DogAPI: TargetType {
    
    var baseURL: String { Host.host }
    
    var path: String {
        switch self {
        case .dog:          return ""
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .dog:          return .get
        }
    }
    
    var task: NetworkTask {
        switch self {
        case .dog:          return .requestPlain
        }
    }
    
}
