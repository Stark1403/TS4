//
//  DogsRouter.swift
//  TestTS4
//
//  Created by cesar.torres on 14/06/23.
//  
//

import Foundation
import UIKit

class DogsRouter: DogsRouterProtocol {
    public var view: DogsView
    private var presenter: DogsPresenter
    private var interactor: DogsInteractor
    init() {
        self.view = DogsView()
        self.presenter = DogsPresenter()
        self.interactor = DogsInteractor()
        view.presenter = self.presenter
        presenter.view = self.view
        presenter.interactor = self.interactor
        presenter.router = self
        interactor.presenter = self.presenter
    }
}

