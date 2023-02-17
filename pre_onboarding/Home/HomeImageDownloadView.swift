//
//  HomeImageDownloadView.swift
//  pre_onboarding
//
//  Created by 홍성준 on 2023/02/17.
//

import UIKit
import SnapKit
import Then

protocol HomeImageDownloadViewDelegate: AnyObject {
    
    func homeImageDownloadViewDidTapLoadButton(_ view: HomeImageDownloadView)
    
}

final class HomeImageDownloadView: UIView {
    
    weak var delegate: HomeImageDownloadViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupLayout()
        self.setupAttributes()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateProgress(_ progress: Float) {
        self.progressView.progress = progress
    }
    
    func setImage(_ url: String?) {
        self.reset()
        self.imageView.setImage(url: url)
        self.progressView.observedProgress = self.imageView.progress
    }
    
    func reset() {
        self.progressView.progress = 0
        self.imageView.cancelDownloadImage()
        self.imageView.image = UIImage(systemName: "photo")?.withRenderingMode(.alwaysTemplate)
        self.progressView.observedProgress = nil
    }
    
    private func setupLayout() {
        self.addSubview(self.imageView)
        self.imageView.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview()
            make.size.equalTo(CGSize(width: 100, height: 60))
        }
        
        self.addSubview(self.loadButton)
        self.loadButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview()
            make.size.equalTo(CGSize(width: 60, height: 30))
        }
        
        self.addSubview(self.progressView)
        self.progressView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(self.imageView.snp.trailing).offset(5)
            make.trailing.equalTo(self.loadButton.snp.leading)
            make.height.equalTo(5)
        }
    }
    
    private func setupAttributes() {
        self.imageView.do {
            $0.image = UIImage(systemName: "photo")?.withRenderingMode(.alwaysTemplate)
        }
        
        self.loadButton.do {
            $0.backgroundColor = .systemBlue
            $0.setTitle("Load", for: .normal)
            $0.layer.cornerRadius = 8
            $0.addTarget(self, action: #selector(loadButtonDidTap(_:)), for: .touchUpInside)
        }
    }
    
    @objc private func loadButtonDidTap(_ sender: UIButton) {
        self.delegate?.homeImageDownloadViewDidTapLoadButton(self)
    }
    
    private let imageView = UIImageView(frame: .zero)
    private let progressView = UIProgressView(frame: .zero)
    private let loadButton = UIButton(frame: .zero)
    
}
