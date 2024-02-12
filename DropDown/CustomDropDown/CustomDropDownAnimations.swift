//
//  CustomDropDownAnimations.swift
//  DropDown
//
//  Created by Владислав Гуденко on 28.01.2024.
//

import Foundation
import UIKit

extension CustomDropDown {
    
    func openOrCloseDropDown() {
        isOpen.toggle()
        print(isOpen ? "ДД открыт" : "ДД закрыт")
        mainHeadView.backgroundColor = .white
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let self = self else { return }
            if self.isOpen {
                self.borderLabel.isHidden = false
                self.rightImageView.image = UIImage(systemName: "control")
                self.mainDropDownStackView.layer.borderWidth = 1
                self.mainDropDownStackView.layer.borderColor = Colors.shared.dropDownBlueColor.cgColor
                self.mainDropDownStackView.addArrangedSubview(self.tableView)
                self.setupTableView()
                self.tableView.visibleCells.forEach { cell in
                    cell.alpha = 0.0
                    cell.transform = CGAffineTransform(translationX: 0, y: 20)
                }
                
                self.tableView.visibleCells.forEach { cell in
                    cell.alpha = 1.0
                    cell.transform = .identity
                }
                
            } else {
                self.snp.remakeConstraints { make in
                    make.centerX.centerY.equalToSuperview()
                    make.leading.trailing.equalToSuperview().inset(20)
                    make.height.equalTo(60)
                }
                self.borderLabel.isHidden = true
                self.rightImageView.image = UIImage(systemName: "restart")
                self.mainDropDownStackView.layer.borderWidth = 1
                self.mainDropDownStackView.layer.borderColor = Colors.shared.dropDownLabelGrayColor.cgColor
                
                self.tableView.visibleCells.forEach { cell in
                    cell.alpha = 0.0
                    cell.transform = CGAffineTransform(translationX: 0, y: 20)
                }
                
                self.tableView.removeFromSuperview()
                self.tableView.visibleCells.forEach { cell in
                    cell.alpha = 1.0
                    cell.transform = .identity
                }
            }
            
            self.layoutIfNeeded()
        }
    }
}
