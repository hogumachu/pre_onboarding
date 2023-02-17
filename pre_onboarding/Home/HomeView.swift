//
//  HomeView.swift
//  pre_onboarding
//
//  Created by 홍성준 on 2023/02/17.
//

import UIKit
import SnapKit
import Then

protocol HomeViewDelegate: AnyObject {
    
    var imageCount: Int { get }
    func homeViewDidTapLoadImageButton(_ view: HomeView, at tag: Int)
    func homeViewDidTapLoadAllImageButton(_ view: HomeView)
    
}

final class HomeView: UIView {
    
    weak var delegate: HomeViewDelegate? {
        didSet { self.updateImageViews() }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupLayout()
        self.setupAttributes()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateImageViews() {
        guard let imageCount = self.delegate?.imageCount else { return }
        self.imageViewStackView
            .subviews
            .forEach { $0.removeFromSuperview() }
        
        self.imageViews = []
        self.imageViews = (0..<imageCount)
            .map { _ in HomeImageDownloadView(frame: .zero) }
            .enumerated()
            .map { offset, view in
                view.do {
                    $0.delegate = self
                    $0.tag = offset
                    self.imageViewStackView.addArrangedSubview($0)
                }
                return view
            }
    }
    
    func updateImage(tag: Int, url: String?) {
        guard let imageView = self.imageViews[safe: tag] else { return }
        imageView.setImage(url)
    }
    
    private func setupLayout() {
        self.addSubview(self.imageViewStackView)
        self.imageViewStackView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
        
        self.addSubview(self.loadAllButton)
        self.loadAllButton.snp.makeConstraints { make in
            make.top.equalTo(self.imageViewStackView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(30)
        }
    }
    
    private func setupAttributes() {
        self.imageViewStackView.do {
            $0.spacing = 10
            $0.axis = .vertical
            $0.distribution = .fillEqually
            $0.alignment = .fill
        }
        
        self.loadAllButton.do {
            $0.backgroundColor = .systemBlue
            $0.setTitle("Load All Images", for: .normal)
            $0.layer.cornerRadius = 8
            $0.addTarget(self, action: #selector(loadAllButtonDidTap(_:)), for: .touchUpInside)
        }
    }
    
    @objc private func loadAllButtonDidTap(_ sender: UIButton) {
        self.delegate?.homeViewDidTapLoadAllImageButton(self)
    }
    
    private var imageViews: [HomeImageDownloadView] = []
    private let imageViewStackView = UIStackView(frame: .zero)
    private let loadAllButton = UIButton(frame: .zero)
    
}

extension HomeView: HomeImageDownloadViewDelegate {
    
    func homeImageDownloadViewDidTapLoadButton(_ view: HomeImageDownloadView) {
        let tag = view.tag
        self.delegate?.homeViewDidTapLoadImageButton(self, at: tag)
    }
    
}
