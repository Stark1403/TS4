//
//  DogsView.swift
//  TestTS4
//
//  Created by cesar.torres on 14/06/23.
//  
//

import UIKit

class DogsView: BaseController {
    @IBOutlet weak var tableViewDogs: UITableView!
    var presenter: DogsPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.getDogsList()
    }

    override func setupView() {
        self.title = "DogsView.title".localized
        self.tableViewDogs.register(UINib(nibName: DogCell.className, bundle: nil), forCellReuseIdentifier: DogCell.className)
    }
    
    func getDogsList() {
        showHUD()
        
        presenter?.getDogs()
    }
}
extension DogsView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.arrayDogs?.count ?? 0
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 240
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableViewDogs.dequeueReusableCell(withIdentifier: DogCell.className) as? DogCell else {
            return UITableViewCell()
        }
        cell.configureDog(entity: presenter?.arrayDogs?[indexPath.row])
        cell.setSelected(false, animated: true)
        return cell
    }
}
extension DogsView: DogsViewProtocol {
    func showMessage(message: String) {
        showMessage(message: message, type: .error)
    }
    
    func successDogsList() {
        hideHUD()
        self.tableViewDogs.reloadData()
    }
}
