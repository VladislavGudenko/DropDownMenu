//
//  FirstViewController + Delegates.swift
//  DropDown
//
//  Created by Владислав Гуденко on 26.01.2024.
//

import Foundation

extension FirstViewController: OpenAddressDelegate {
    func openAddress() {
        let addAdresVC = SecondViewController()
        addAdresVC.addAddressClosure = { [weak self] adress in
            self?.customDD.items.append(adress)
            self?.customDD.tableView.reloadData()
        }
        present(addAdresVC, animated: true)
    }
}
