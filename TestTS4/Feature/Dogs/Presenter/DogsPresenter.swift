//
//  DogsPresenter.swift
//  TestTS4
//
//  Created by cesar.torres on 14/06/23.
//  
//

import Foundation

class DogsPresenter: DogsPresenterProtocol {
    
    var view: DogsViewProtocol?
    var interactor: DogsInteractorProtocol?
    var router: DogsRouterProtocol?
    var arrayDogs: [DogsResponse]?
    
    func getDogs() {
        interactor?.fetchDogs()
    }
    
    func didFetchDogs() {
        view?.successDogsList()
    }
    
    func showErrorMessage(message: String) {
        view?.showMessage(message: message)
    }
}
