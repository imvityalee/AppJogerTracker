//
//  JogsViewController.swift
//  AppJogerTracker
//
//  Created by Victor Lee on 18/10/21.
//

import Foundation
import UIKit

class JogsViewController: BaseViewController<JogsView, JogsViewModel>  {
    
    lazy var dataSource = JogsTableViewDataSource.dataSource(contentView.jogsTabelView)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        contentView.jogsTabelView.rx.setDelegate(self)
            .disposed(by: disposableBag)
        
        
    }
    
    private func bindViewModel() {
        
        let input = JogsViewModel.Input(menuTrigger: contentView.menuButton.rx.tap.asDriver(),
                                        addTrigger: contentView.addJogsButton.rx.tap.asDriver(),
                                        itemSelected: contentView.jogsTabelView.rx.itemSelected.asDriver())
        let output = viewModel.transform(input: input)
        
        disposableBag.insert([output.sections.drive(contentView.jogsTabelView.rx.items(dataSource: dataSource)),
                              output.addTapped.drive(),
                              output.menuTapped.drive(),
                              viewModel.onErrorHandling
                                .skip(1)
                                .subscribe { [weak self] error in
            self?.showAlert(title: "\(NetworkError.invalidAuthentication)",
                            message: LabelConstants.tryAgain)
        }
    ])
        
    }
    
}

