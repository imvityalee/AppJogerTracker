//
//  JogsViewController.swift
//  AppJogerTracker
//
//  Created by Victor Lee on 18/10/21.
//

import Foundation
import UIKit

class JogsViewController: BaseViewController<JogsView, JogsViewModel>  {
    
    lazy var dataSource = JogsTableViewDataSource.dataSource(conentView.jogsTabelView)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        conentView.jogsTabelView.rx.setDelegate(self)
    }
    
    private func bindViewModel() {
        
        let input = JogsViewModel.Input(menuTrigger: conentView.menuButton.rx.tap.asDriver(),
                                        addTrigger: conentView.addJogsButton.rx.tap.asDriver())
        let output = viewModel.transform(input: input)
     
        disposableBag.insert([output.sections.drive(conentView.jogsTabelView.rx.items(dataSource: dataSource)),
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

