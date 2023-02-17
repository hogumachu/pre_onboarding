//
//  HomeViewController.swift
//  pre_onboarding
//
//  Created by 홍성준 on 2023/02/17.
//

import UIKit
import SnapKit
import Then
import RxSwift

final class HomeViewController: UIViewController {
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.setupHomeView()
        self.bind(viewModel: viewModel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupHomeView() {
        self.view.backgroundColor = .white
        
        self.view.addSubview(self.homeView)
        self.homeView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(20)
        }
        
        self.homeView.delegate = self
    }
    
    private func bind(viewModel: HomeViewModel) {
        viewModel
            .viewModelEvent
            .withUnretained(self)
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(onNext: { viewController, event in viewController.handle(event) })
            .disposed(by: self.disposeBag)
    }
    
    private func handle(_ event: HomeViewModelEvent) {
        switch event {
        case .updateImage(let tag, let url):
            self.homeView.updateImage(tag: tag, url: url)
        }
    }
    
    private let homeView = HomeView(frame: .zero)
    private let viewModel: HomeViewModel
    private let disposeBag = DisposeBag()

}

extension HomeViewController: HomeViewDelegate {
    
    var imageCount: Int {
        self.viewModel.numberOfImages
    }
    
    func homeViewDidTapLoadAllImageButton(_ view: HomeView) {
        self.viewModel.downloadAllImages()
    }
    
    func homeViewDidTapLoadImageButton(_ view: HomeView, at tag: Int) {
        self.viewModel.downloadImage(at: tag)
    }
    
}
