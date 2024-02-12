import UIKit
import SnapKit

class SecondViewController: UIViewController, UITextFieldDelegate {
    
    weak var delegate: AdresDelegate?
    var addAddressClosure: ((String) -> Void)?

    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.delegate = self
        textField.resignFirstResponder()
        textField.placeholder = "Введите адрес"
        return textField
    }()
    
    lazy var enterButton: UIButton = {
        let button = UIButton()
        button.setTitle("Подтвердить", for: .normal)
        button.setTitleColor(Colors.shared.dropDownBlueColor, for: .normal)
        button.addTarget(self, action: #selector(enterTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        addViews()
        setupLayout()
        
    }
    
    @objc func enterTapped() {
        guard let adres = textField.text, !adres.isEmpty else {
            return
        }
        addAddressClosure?(adres)
        dismiss(animated: true)
    }
    
    func addViews() {
        view.addSubview(textField)
        view.addSubview(enterButton)
    }
    
    func setupLayout() {
        textField.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(200)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
        
        enterButton.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(40)
            make.leading.trailing.equalToSuperview()
        }
    }
    
    func openAdressScene(adress: ((String?) -> Void)) {
        
    }


}
