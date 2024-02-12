

import UIKit
import SnapKit

class DropDownTableViewCell: UITableViewCell {
    
    weak var delegate: CellDelegate?
    var closure: (() -> Void)?
    
    let emptyAdressLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = Colors.shared.dropDownLabelGrayColor
        return label
    }()
    
    let addressLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    
    let addButton: UIButton = {
        let button = UIButton()
        button.setTitle("Добавить", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        return button
    }()
    
    var isAddButtonCell: Bool = false {
        didSet {
            updateUI()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setupUI() {
        contentView.addSubview(emptyAdressLabel)
        contentView.addSubview(addressLabel)
        contentView.addSubview(addButton)
        
        emptyAdressLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
        }
        
        addressLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
        }
        
        addButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
        }
    }
    
    func updateUI() {
        addressLabel.isHidden = isAddButtonCell
        addButton.isHidden = !isAddButtonCell
    }
    
    func configure(with address: String?) {
        if isAddButtonCell {
            addButton.setTitle("Добавить адрес", for: .normal)
            addressLabel.text = nil
        } else {
            emptyAdressLabel.text = nil
            addButton.removeFromSuperview()
            addButton.setTitle(nil, for: .normal)
            addressLabel.text = address
        }
    }
    
    func configureIfAdressNil() {
        addButton.setTitle("Добавить", for: .normal)
        emptyAdressLabel.text = "Нет добавленных адресов"
    }
    
    func configureWithAdress() {
        addButton.setTitle("Добавить", for: .normal)
        addButton.snp.remakeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
        }
    }
    
    @objc func addButtonTapped() {
        delegate?.addButtonTapped()
    }

}
