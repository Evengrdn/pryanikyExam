//
//  ViewConfig.swift
//  pryanikyExam
//
//  Created by Maksim Kuznecov on 24.08.2022.
//

import Foundation
import UIKit


class MasterViewConfig: NSObject, Decodable, ViewFactoryEntityProtocol  {
    func configure() -> UIView {
        UIView()
    }
}
