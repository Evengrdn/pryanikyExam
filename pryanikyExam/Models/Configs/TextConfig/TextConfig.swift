//
//  TextConfig.swift
//  pryanikyExam
//
//  Created by Максим Кузнецов on 23.08.2022.
//

import Foundation
import UIKit

final class TextConfig : MasterViewConfig {
    var text: String
    
    private enum CodingKeys: String, CodingKey {
        case text
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.text = try container.decode(String.self, forKey: .text)
        try super.init(from: decoder)
    }
    
    override func configure() -> UIView {
        let label = TextConfigView(title: self.text)
        return label
    }
    
}
