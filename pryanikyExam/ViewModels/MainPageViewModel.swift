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
import RxGesture

final class MainPageViewModel {
    
    let views = PublishSubject<UIView>()
    
    weak var controller: UIViewController?
    
    init(controller: UIViewController) {
        self.controller = controller
    }
    
    func getViews() {
        AF.request("https://pryaniky.com/static/json/sample.json").responseDecodable(of: ViewBuilder.self ) { response in
            guard let views = response.value else {return}
            views.view.forEach { viewType in
                let viewConfig = views.data.first { config in
                    config.name == viewType
                }
                
                guard let viewConfig = viewConfig else {return}
                let configuredView = ViewFactory.getView(config: viewConfig.data)
                
                configuredView.rx.tapGesture()
                    .when(.recognized)
                    .subscribe(onNext: {[weak self]  _ in
                        let alert = UIAlertController(title: "Test", message: "test?", preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                                    print("asda")
                                }))
                        self?.controller?.present(alert, animated: true)
                    })
                
                self.views.onNext(configuredView)
            }
        }
    }
    
}
