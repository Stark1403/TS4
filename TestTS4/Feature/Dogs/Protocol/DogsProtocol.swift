//
//  DogsProtocol.swift
//  TestTS4
//
//  Created by cesar.torres on 14/06/23.
//  
//

protocol DogsViewProtocol: AnyObject {
    var presenter: DogsPresenterProtocol? { get set }
    func successDogsList()
    func showMessage(message: String)
}

protocol DogsRouterProtocol: AnyObject {
}

protocol DogsPresenterProtocol: AnyObject {
    var view: DogsViewProtocol? { get set }
    var interactor: DogsInteractorProtocol? { get set }
    var router: DogsRouterProtocol? { get set }
    var arrayDogs: [DogsResponse]? { get set}
    func getDogs()
    func didFetchDogs()
    func showErrorMessage(message: String)
    
}

protocol DogsInteractorProtocol: AnyObject {
    var presenter: DogsPresenterProtocol? { get set }
    func fetchDogs()
}


