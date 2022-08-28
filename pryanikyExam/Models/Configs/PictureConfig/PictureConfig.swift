//
//  PictureConfig.swift
//  pryanikyExam
//
//  Created by Максим Кузнецов on 23.08.2022.
//

import Foundation
import UIKit

final class PictureConfig : MasterViewConfig {
    
    var url: URL?
    var text: String
    
    private enum CodingKeys: String, CodingKey {
        case url
        case text
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.url = try container.decode(URL.self, forKey: .url)
        self.text = try container.decode(String.self, forKey: .text)
        try super.init(from: decoder)
    }
    
    override func configure() -> UIView {
        let label = PictureConfigView(url: self.url)
        return label
    }
    
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
