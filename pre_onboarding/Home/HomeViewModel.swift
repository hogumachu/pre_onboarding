//
//  HomeViewModel.swift
//  pre_onboarding
//
//  Created by 홍성준 on 2023/02/17.
//

import Foundation
import RxSwift
import RxRelay

enum HomeViewModelEvent {
    
    case updateImage(tag: Int, url: String)
    
}

final class HomeViewModel {
    
    
    typealias ResponseModel = Dog.ResponseModel
    
    private(set) var numberOfImages: Int = 5
    
    var viewModelEvent: Observable<HomeViewModelEvent> {
        self.viewModelEventRelay.asObservable()
    }
    
    func downloadAllImages() {
        (0..<self.numberOfImages).forEach {
            self.request(at: $0)
        }
    }
    
    func downloadImage(at tag: Int) {
        self.request(at: tag)
    }
    
    private func request(at tag: Int) {
        Task { [weak self] in
            do {
                let model: ResponseModel? = try await self?.dogProvider.request(.dog)
                self?.performAfterRequest(model, at: tag)
            } catch {
                // TODO: - Error Handling
                print("## ERROR")
            }
        }
    }
    
    private func performAfterRequest(_ model: ResponseModel?, at tag: Int) {
        guard let model = model,
              let url = model.url,
              url.isEmpty == false
        else {
            // TODO: - Error Handling
            return
        }
        self.viewModelEventRelay.accept(.updateImage(tag: tag, url: url))
    }
    
    private let dogProvider = NetworkProvider<DogAPI>()
    private let viewModelEventRelay = PublishRelay<HomeViewModelEvent>()
    
}
