//
//  CustomTableView.swift
//  DropDown
//
//  Created by Владислав Гуденко on 27.01.2024.
//

import Foundation
import UIKit

class CustomTableView: UITableView {
    
    override var contentSize: CGSize {
        didSet {
            invalidateIntrinsicContentSize()
            setNeedsLayout()
        }
    }

    override var intrinsicContentSize: CGSize {
        let height = min(.infinity, contentSize.height)
        return CGSize(width: contentSize.width, height: height)
    }
}
