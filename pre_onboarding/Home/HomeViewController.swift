//
//  HomeViewController.swift
//  pre_onboarding
//
//  Created by 홍성준 on 2023/02/17.
//

import UIKit
import SnapKit
import Then

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
        
    }
    
    private let homeView = HomeView(frame: .zero)
    private let viewModel: HomeViewModel

}

extension HomeViewController: HomeViewDelegate {
    
    func homeViewDidTapLoadAllImageButton(_ view: HomeView) {
        print("## Download All Images")
    }
    
    func homeViewDidTapLoadImageButton(_ view: HomeView, at tag: Int) {
        print("## Download Image at \(tag)")
    }
    
}
