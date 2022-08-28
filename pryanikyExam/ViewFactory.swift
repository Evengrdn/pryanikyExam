//
//  ViewFactory.swift
//  pryanikyExam
//
//  Created by Maksim Kuznecov on 25.08.2022.
//

import Foundation
import UIKit

enum ViewFactory {
    
    static func getView(config: ViewFactoryEntityProtocol) -> UIView{
        config.configure()
    }
}
