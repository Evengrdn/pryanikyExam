//
//  ViewBuilder.swift
//  pryanikyExam
//
//  Created by Максим Кузнецов on 23.08.2022.
//

import Foundation

struct ViewBuilder: Decodable {
    var data: [ViewConfig]
    var view: [ViewConfigType]
}
