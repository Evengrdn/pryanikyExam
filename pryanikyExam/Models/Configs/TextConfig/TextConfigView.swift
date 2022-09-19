//
//  TextConfigView.swift
//  pryanikyExam
//
//  Created by Maksim Kuznecov on 26.08.2022.
//

import Foundation
import UIKit

class TextConfigView: UIView, ConfigView {
    
    func viewInformation() {
        print("text")
    }
    
    
    lazy var labelView: UILabel = {
        let lable = UILabel()
        lable.text = self.title
        lable.textAlignment = .center
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    var title: String
    
    init(title: String) {
        self.title = title
        super.init(frame: CGRect())
        addSubview(labelView)
        translatesAutoresizingMaskIntoConstraints = false
        setupNSLayoutConstrains()
        
    }
    
    func setupNSLayoutConstrains() {
        NSLayoutConstraint.activate([
            labelView.leadingAnchor.constraint(equalTo: leadingAnchor),
            labelView.bottomAnchor.constraint(equalTo: bottomAnchor),
            labelView.trailingAnchor.constraint(equalTo: trailingAnchor),
            labelView.topAnchor.constraint(equalTo: topAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func aboutMe() -> String{
        "Text field"
    }
}
