//
//  PictureConfigView.swift
//  pryanikyExam
//
//  Created by Maksim Kuznecov on 26.08.2022.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

protocol ConfigView: UIView {
    func viewInformation()
}

//extension ConfigView where Self: UIView {
//    func viewInformation() {
//        let alert = UIAlertController(title: "Test", message: "test?", preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
//            print("asda")
//        }))
//    }
//}


class PictureConfigView: UIView, ConfigView {
    func viewInformation() {
        print("picture")
    }
    
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    var url: URL?
    
    init(url: URL?) {
        self.url = url
        super.init(frame: CGRect())
        addSubview(imageView)
        if let url = self.url {
            imageView.load(url: url)
        }
        translatesAutoresizingMaskIntoConstraints = false
        setupNSLayoutConstrains()
    }
    
    func setupNSLayoutConstrains() {
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
