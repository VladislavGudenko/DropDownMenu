//
//  CustomDropDown.swift
//  DropDown
//
//  Created by Владислав Гуденко on 28.01.2024.
//

import Foundation
import UIKit
import SnapKit

final class CustomDropDown: UIView, CellDelegate {
    
    weak var openAddressDelegate: OpenAddressDelegate?
    
    func addButtonTapped() {
        openAddressDelegate?.openAddress()
    }
    
    init(borderLabeltext: String,
         borderLabelTextColor: UIColor,
         placeholderLabelText: String,
         placeholderLabelTextColor: UIColor,
         mainHeadViewBackgroundColor: UIColor,
         cornerRadius: CGFloat,
         borderLabelFont: UIFont,
         placeholderLabelFont: UIFont,
         rightImage: UIImage,
         viewsHeight: UInt,
         borderLabelLeadingInset: UInt,
         placeholderLabelLeadingInset: UInt,
         rightImageViewTrailingInset: UInt,
         classCell: AnyClass) {
        super.init(frame: .zero)
        
        tableView.dataSource = self
        tableView.delegate = self
        self.borderLabel.text = borderLabeltext
        self.borderLabel.textColor = borderLabelTextColor
        self.placeholderLabel.text = placeholderLabelText
        self.placeholderLabel.textColor = placeholderLabelTextColor
        self.mainHeadView.layer.cornerRadius = cornerRadius
        self.mainHeadView.backgroundColor = mainHeadViewBackgroundColor
        self.mainDropDownStackView.layer.cornerRadius = cornerRadius
        self.borderLabel.font = borderLabelFont
        self.placeholderLabel.font = placeholderLabelFont
        self.rightImageView.image = rightImage
        self.tableView.register(classCell, forCellReuseIdentifier: "cell")
        setupUI()
        setupConstraints(viewHeight: viewsHeight, borderLabelLeadingInset: borderLabelLeadingInset, placeholderLabelLeadingInset: placeholderLabelLeadingInset, rightImageViewTrailingInset: rightImageViewTrailingInset)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var isOpen = false
    var items: [String] = ["222", "333"]
    
    lazy var mainDropDownStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()
    
    lazy var mainHeadView: UIView = {
        let view = UIView()
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dropDownTap(_:)))
        view.addGestureRecognizer(tapGestureRecognizer)
        return view
    }()
    
    lazy var borderLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.isHidden = true
        return label
    }()
    
    lazy var placeholderLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var rightImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    var tableView = CustomTableView()
    
    @objc func dropDownTap(_ sender: UITapGestureRecognizer) {
        openOrCloseDropDown()
    }
    
    func setupUI() {
        self.addSubview(mainDropDownStackView)
        self.addSubview(borderLabel)
        self.mainDropDownStackView.addArrangedSubview(mainHeadView)
        self.mainHeadView.addSubview(placeholderLabel)
        self.mainHeadView.addSubview(rightImageView)
    }
    
    func setupConstraints(viewHeight: UInt, borderLabelLeadingInset: UInt, placeholderLabelLeadingInset: UInt, rightImageViewTrailingInset: UInt) {
        mainDropDownStackView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(viewHeight)
        }
        borderLabel.snp.makeConstraints { make in
            make.centerY.equalTo(mainDropDownStackView.snp.top)
            make.leading.equalToSuperview().inset(borderLabelLeadingInset)
        }
        mainHeadView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(viewHeight)
        }
        placeholderLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(placeholderLabelLeadingInset)
            make.centerY.equalToSuperview()
        }
        rightImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(rightImageViewTrailingInset)
            make.centerY.equalToSuperview()
        }
        
    }
    
    func setupTableView() {
        tableView.backgroundColor = .white
        tableView.separatorColor = .clear
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44.0
        
        if !mainDropDownStackView.arrangedSubviews.contains(tableView) {
            mainDropDownStackView.addArrangedSubview(tableView)
        }
        
        mainDropDownStackView.removeConstraints(mainDropDownStackView.constraints)
        
        mainDropDownStackView.snp.remakeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(tableView.snp.bottom).offset(20)
        }
        
        tableView.snp.remakeConstraints { make in
            make.leading.trailing.equalToSuperview()
        }
        
        if items.count > 5 {
            tableView.snp.remakeConstraints { make in
                make.height.equalTo(264)
            }
        } else {
            self.snp.remakeConstraints { make in
                make.centerX.centerY.equalToSuperview()
                make.leading.trailing.equalToSuperview().inset(20)
                make.height.equalTo(mainDropDownStackView)
            }
        }
    }
}

extension CustomDropDown: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == items.count {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? DropDownTableViewCell else {
                return UITableViewCell()
            }
            if items.count != 0 {
                cell.configureWithAdress()
                cell.delegate = self
            } else {
                cell.configureIfAdressNil()
                cell.delegate = self
            }
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? DropDownTableViewCell else {
                return UITableViewCell()
            }
            
            cell.configure(with: items[indexPath.row])
            cell.delegate = self
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == items.count {
            print("пустое нажатие на последнюю ячейку")
        } else {
            self.openOrCloseDropDown()
        }
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return indexPath.row != items.count
    }
}
