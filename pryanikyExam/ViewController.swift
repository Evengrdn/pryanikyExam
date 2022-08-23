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
    
    
    let fetchButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Fetch data", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(fetchButton)
        
        
        NSLayoutConstraint.activate([
            fetchButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            fetchButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            fetchButton.widthAnchor.constraint(equalToConstant: 200),
            fetchButton.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        fetchButton.rx.tap
            .debounce(.milliseconds(300), scheduler: MainScheduler.instance )
            .subscribe(
                onNext: {
                    AF.request("https://pryaniky.com/static/json/sample.json", encoder: JSONParameterEncoder.default).response { response in
                        debugPrint(response)
                    }
                }
            ) .disposed(by: bag)
        
        // Do any additional setup after loading the view.
    }
    
    
}

