//
//  TargetType.swift
//  pre_onboarding
//
//  Created by 홍성준 on 2023/02/17.
//

import Foundation

protocol TargetType {
    
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var task: NetworkTask { get }
    
}
