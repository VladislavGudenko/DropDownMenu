import UIKit
import SnapKit


typealias AddAddressClosure = (String) -> Void

class FirstViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        checkDD()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        reloadTable()
    }

    let customDD = CustomDropDown(borderLabeltext: "Test Border Label",
                                  borderLabelTextColor: Colors.shared.dropDownBlueColor,
                                  placeholderLabelText: "Test Placeholder",
                                  placeholderLabelTextColor: Colors.shared.dropDownLabelGrayColor,
                                  mainHeadViewBackgroundColor: Colors.shared.dropDownGrayColor,
                                  cornerRadius: 15,
                                  borderLabelFont: UIFont.systemFont(ofSize: 12),
                                  placeholderLabelFont: UIFont.systemFont(ofSize: 16),
                                  rightImage: UIImage(systemName: "restart")!,
                                  viewsHeight: 60,
                                  borderLabelLeadingInset: 20,
                                  placeholderLabelLeadingInset: 20,
                                  rightImageViewTrailingInset: 12,
                                  classCell: DropDownTableViewCell.self)
    
    func checkDD() {
        customDD.openAddressDelegate = self
        view.addSubview(customDD)
        customDD.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(60)
        }
    }
}

