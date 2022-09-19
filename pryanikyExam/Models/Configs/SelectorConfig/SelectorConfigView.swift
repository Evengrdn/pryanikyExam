//
//  SelectorConfigView.swift
//  pryanikyExam
//
//  Created by Maksim Kuznecov on 28.08.2022.
//

import Foundation
import UIKit

class SelectorConfigView: UIView, UIPickerViewDataSource, UIPickerViewDelegate, ConfigView  {
    func viewInformation() {
        print("selector")
    }
    
    lazy var picker: UIPickerView = {
        let picker = UIPickerView()
        picker.delegate = self
        picker.dataSource = self
        picker.contentMode = .scaleToFill
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    var variants: [SelectorVariants]
    
    init(variants: [SelectorVariants]) {
        self.variants = variants
        super.init(frame: CGRect())
        addSubview(picker)
        translatesAutoresizingMaskIntoConstraints = false
        setupNSLayoutConstrains()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupNSLayoutConstrains() {
        NSLayoutConstraint.activate([
            picker.leadingAnchor.constraint(equalTo: leadingAnchor),
            picker.bottomAnchor.constraint(equalTo: bottomAnchor),
            picker.trailingAnchor.constraint(equalTo: trailingAnchor),
            picker.topAnchor.constraint(equalTo: topAnchor),            
        ])
    }
}

extension SelectorConfigView {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        variants.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let title = variants[row].text
        return title
    }
}
