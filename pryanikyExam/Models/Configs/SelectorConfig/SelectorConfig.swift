//
//  SelectorConfig.swift
//  pryanikyExam
//
//  Created by Максим Кузнецов on 23.08.2022.
//

import Foundation
import UIKit

final class SelectorConfig: MasterViewConfig  {
    var selectedId: Int
    var variants: [SelectorVariants]
    
    private enum CodingKeys: String, CodingKey {
        case selectedId = "selectedId"
        case variants
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.selectedId = try container.decode(Int.self, forKey: .selectedId)
        self.variants = try container.decode([SelectorVariants].self, forKey: .variants)
        try super.init(from: decoder)
    }
    
    override func configure() -> UIView {
        let picker = SelectorConfigView(variants: self.variants)
        return picker
    }
    
}
