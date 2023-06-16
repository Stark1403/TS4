//
//  DogsInteractor.swift
//  TestTS4
//
//  Created by cesar.torres on 14/06/23.
//  
//

import Foundation


class DogsInteractor {
    var presenter: DogsPresenterProtocol?
    let userDefaults = UserDefaults.standard
    let keyForUserDefaults = "dogs"
    var connection = Connection()
}

extension DogsInteractor: DogsInteractorProtocol {
    func fetchDogs() {
        presenter?.arrayDogs = []
        guard let dogs = getDogsDataBase() else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.connection.connectionRequest(url: "https://jsonblob.com/api/jsonBlob/1118692511161008128", method: .get) { (_ result: Result<Dogs?>) in
                    switch result {
                    case let .success(response):
                        self.presenter?.arrayDogs = response?.dogs
                        self.saveDataDogs(entity: response?.dogs)
                        self.presenter?.didFetchDogs()
                    case let .failure(error):
                        self.presenter?.showErrorMessage(message: error)
                    }
                }
            }
            return
        }
        
        presenter?.arrayDogs = dogs
        presenter?.didFetchDogs()
       
    }
    
    func getDogsDataBase() -> [DogsResponse]? {
        do {
            let dogsEntity = try userDefaults.getObject(forKey: keyForUserDefaults, castTo: [DogsResponse].self)
            if dogsEntity.count > 0 {
                return dogsEntity
            } else {
               return nil
            }
        } catch {
            return nil
        }
    }
    
    
    func saveDataDogs(entity: [DogsResponse]?) {
        do {
            try userDefaults.setObject(entity, forKey: keyForUserDefaults)
        } catch {
            print(error.localizedDescription)
        }
    }
}
