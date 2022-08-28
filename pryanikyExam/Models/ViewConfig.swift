//
//  ViewConfig.swift
//  pryanikyExam
//
//  Created by Максим Кузнецов on 23.08.2022.
//

import Foundation

final class ViewConfig: Decodable {
    var name: ViewConfigType
    var data: MasterViewConfig
    
    private enum CodingKeys: String, CodingKey {
        case name
        case data
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let name = try container.decode(ViewConfigType.self, forKey: .name)
        switch name {
            case .hz:
                self.data  = try container.decode(TextConfig.self, forKey: .data)
            case .picture:
                self.data  = try container.decode(PictureConfig.self, forKey: .data)
            case .selector:
                self.data  = try container.decode(SelectorConfig.self, forKey: .data)
        }
        self.name = name;
    }
}
