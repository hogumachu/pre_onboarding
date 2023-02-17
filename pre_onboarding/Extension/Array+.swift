//
//  Array+.swift
//  pre_onboarding
//
//  Created by 홍성준 on 2023/02/17.
//

import Foundation

extension Array {
    
    subscript (safe index: Int) -> Element? {
        self.indices ~= index ? self[index] : nil
    }
    
}
