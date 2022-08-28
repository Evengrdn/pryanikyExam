//
//  ViewController.swift
//  pryanikyExam
//
//  Created by Максим Кузнецов on 23.08.2022.
//

import UIKit
import RxSwift
import RxCocoa
import Alamofire

class ViewController: UIViewController {
    
    let bag = DisposeBag()
    var response: ViewBuilder?
    
    let customBuilderView = BehaviorSubject<UIView>(value: UIView())
    
    
    let fetchButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Fetch data", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(fetchButton)
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            
            fetchButton.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            fetchButton.widthAnchor.constraint(equalToConstant: 200),
            fetchButton.heightAnchor.constraint(equalToConstant: 50),
            fetchButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            
            scrollView.topAnchor.constraint(equalTo: fetchButton.bottomAnchor, constant: 20),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
        ])
        
        fetchButton.rx.tap
            .debounce(.milliseconds(300), scheduler: MainScheduler.instance )
            .subscribe(
                onNext: {
                    AF.request("https://pryaniky.com/static/json/sample.json").responseDecodable(of: ViewBuilder.self ) { response in
//                        self.viewFactory.make(configs: response.value!, targetView: self.stackView)
                    }
                }
            ).disposed(by: bag)
        
        
        //        checkData.rx.tap
        //            .debounce(.microseconds(300), scheduler: MainScheduler.instance)
        //            .subscribe(
        //                onNext: {
        //                guard let response = self.response else {
        //                    print("Empty")
        //                    return
        //                }
        //
        //                    self.viewFactory.make(configs: response, targetView: self.scrollView)
        ////                    self.customBuilderView.onNext(view)
        //            }).disposed(by: bag)
        
        
        //        customBuilderView.subscribe(onNext: { constructedView in
        //            self.view.addSubview(constructedView)
        //        })
        
        
        // Do any additional setup after loading the view.
    }
    
    
}

