//
//  MainPageViewModel.swift
//  pryanikyExam
//
//  Created by Maksim Kuznecov on 28.08.2022.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import Alamofire

final class MainPageViewModel {
    
    let views = PublishSubject<UIView>()
    
    func getViews() {
        AF.request("https://pryaniky.com/static/json/sample.json").responseDecodable(of: ViewBuilder.self ) { response in
            guard let views = response.value else {return}
            views.view.forEach { viewType in
                let viewConfig = views.data.first { config in
                    config.name == viewType
                }
                
                guard let viewConfig = viewConfig else {return}
                let configuredView = ViewFactory.getView(config: viewConfig.data)
                self.views.onNext(configuredView)
            }
        }
    }
    
}
