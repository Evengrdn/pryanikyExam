//
//  MainPageView.swift
//  pryanikyExam
//
//  Created by Maksim Kuznecov on 28.08.2022.
//

import UIKit
import RxSwift
import RxCocoa

class MainPageView: UIViewController {
    
    let viewModel = MainPageViewModel()
    let bag = DisposeBag()
    
    let fetchButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Fetch views", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let clearButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Clear views", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let fetchWithClearButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Clead and fetch views", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let buttonPanel: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        return stackView
    }()
    
    let scroll: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    let contentStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupViews()
        setupNSLayoutConstraints()
        setupBinds()
    }
    
    func setupViews() {
        view.addSubview(buttonPanel)
        buttonPanel.addArrangedSubview(fetchButton)
        buttonPanel.addArrangedSubview(clearButton)
        buttonPanel.addArrangedSubview(fetchWithClearButton)
        view.addSubview(scroll)
        scroll.addSubview(contentStack)
    }
    
    func setupNSLayoutConstraints() {
        NSLayoutConstraint.activate([
            buttonPanel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            buttonPanel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            scroll.topAnchor.constraint(equalTo: buttonPanel.bottomAnchor, constant: 20),
            scroll.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scroll.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scroll.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            contentStack.topAnchor.constraint(equalTo: scroll.topAnchor),
            contentStack.leadingAnchor.constraint(equalTo: scroll.leadingAnchor),
            contentStack.trailingAnchor.constraint(equalTo: scroll.trailingAnchor),
            contentStack.bottomAnchor.constraint(equalTo: scroll.bottomAnchor),
            contentStack.widthAnchor.constraint(equalTo: scroll.widthAnchor),
        ])
    }
    
    func setupBinds() {
        fetchButton.rx.tap
            .debounce(.milliseconds(300), scheduler: MainScheduler.instance)
            .subscribe(
                onNext: {
                    self.viewModel.getViews()
                }
            ).disposed(by: bag)
        
        clearButton.rx.tap
            .debounce(.milliseconds(300), scheduler: MainScheduler.instance)
            .subscribe(
                onNext: {
                    let subViews = self.contentStack.subviews
                    for subview in subViews{
                        subview.removeFromSuperview()
                    }
                }
            ).disposed(by: bag)
        
        fetchWithClearButton.rx.tap
            .debounce(.milliseconds(300), scheduler: MainScheduler.instance)
            .subscribe(
                onNext: {
                    self.clearButton.sendActions(for: .touchUpInside)
                    self.fetchButton.sendActions(for: .touchUpInside)
                }
            ).disposed(by: bag)
        
        
        viewModel.views
            .asDriver(onErrorJustReturn: UIView())
            .drive(onNext: { [weak self] view in
                guard let self = self else {return}
                self.contentStack.addArrangedSubview(view)
            }).disposed(by: bag)
    }
}
