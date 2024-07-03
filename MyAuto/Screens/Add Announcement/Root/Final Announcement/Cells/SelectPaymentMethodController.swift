//
//  SelectPaymentMethodController.swift
//  KeepPet2
//
//  Created by User on 27.05.24.
//

import Foundation
import RxSwift
import WebKit

final class SelectPaymentMethodController: BaseViewController, ApplePayViewControllerDelegate {
    func successAccountCreated() {
        self.accauntCreatedLabel.isHidden = false
        self.checkBoxHolderView.isHidden = true
        subscribeLabel.text = "Subscribe & Start Free Trial"
    }
    
    
    private var accountManager = AppDelegate.appContext.serviceFactory.accountManager()
    private var emailArray: [String] = []

    func getError(error: String) {
        self.dismiss(animated: true) {
            self.showAlertwithTitle(title: "Error", message: error)
        }
    }
    
    func didFinishPaymentFromApplePay() {
        self.dismiss(animated: true) {
            let isEditing = !UserKeys.kAuthToken.isEmpty
            let paymentLoadingView = PayWallPaymentLoadingViewFactory.create(isEdit: isEditing, isFromApplePay: true)
            
            self.show(paymentLoadingView, sender: nil)
        }
    }
    
    private let emailInputTextField: KPTitleTextField = {
       let textField = KPTitleTextField()
        textField.inputTextField.placeholder = "E-mail"
        textField.inputTextField.textContentType = .username
        textField.inputTextField.keyboardType = .emailAddress
        textField.inputTextField.setLeftIcon(.email)
        textField.titleLabel.text = "Account Information"
        textField.titleLabel.textColor = .black
        return textField
    }()
    
    private let holderStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        
        return stackView
    }()
    
    private let firstNameTextField: KPTitleTextField = {
        let textField = KPTitleTextField()
        textField.inputTextField.placeholder = "First name"
        textField.inputTextField.setLeftIcon(.user)
        return textField
    }()
    
    private let lastNameTextField: KPTitleTextField = {
        let textField = KPTitleTextField()
        textField.inputTextField.placeholder = "Last name"
        textField.inputTextField.setLeftIcon(.user)
        return textField
    }()
    
    private let checkBoxHolderView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    private let userAgreesCheckboxButton: KPCheckBoxButton = {
       let button = KPCheckBoxButton()
        button.style = .tick
        button.isChecked = false
        button.checkmarkColor = R.color.brandGreen()!
        button.borderStyle = .roundedSquare(radius: 4)
        button.checkedBorderColor = R.color.brandGreen()!
        button.uncheckedBorderColor = R.color.brandGreen()!
        return button
    }()
    
    private let userAgreesLabel: UILabel = {
       let label = UILabel()
        label.textColor = R.color.brandDarkGrey()
        label.font = UIFont.systemFont(ofSize: 13)
        let labelText = "I agree with KeepPet Terms."
        label.halfTextColorChangeWithUnderline(fullText: labelText, changeText: "KeepPet Terms.", color: .AppColor.brandGreen)
        return label
    }()
    
    private let accauntCreatedLabel: UILabel = {
        let label = UILabel()
        label.text = "Your account have been already created."
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = R.color.textColor()
        label.isHidden = true
        
        return label
    }()
    
    private let userAgreeButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    private let addCardManuallyButton: UIButton = {
        let button = UIButton()
        let title = "Add Card manually".uppercased()
        
        let attributes: [NSAttributedString.Key: Any] = [
            .underlineStyle: NSUnderlineStyle.single.rawValue,
            .font: UIFont.systemFont(ofSize: 14, weight: .bold),
            .foregroundColor: UIColor(.black)
        ]
        let attributedTitle = NSAttributedString(string: title, attributes: attributes)
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.textAlignment = .center
        button.addTarget(self, action: #selector(tappedAddCardManually), for: .touchUpInside)
        return button
    }()
    
    private let choiceOtherSigninContainerStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.spacing = 2
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalCentering
        return stackView
    }()
    
    private let orContinueWithOtherLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Or"
        label.textColor = R.color.brandDarkGrey()
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    private let applePayBtn: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "applePayButton"), for: .normal)
        button.addTarget(nil, action: #selector(tappedApplePay), for: .touchUpInside)
        return button
    }()
    
    private let subscribeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Create an account and\nsubscribe with free trial"
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    private let moneyBackView: MoneyBackView = {
        let view = MoneyBackView()

        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setAppLogoToNavigationTitle()
        setupUI()
        userAgreementConfigure()
    }
    
    func setupUI() {
        contentView.addSubview(emailInputTextField)
        emailInputTextField.snp.makeConstraints {
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.top.equalToSuperview().offset(34)
        }
        
        contentView.addSubview(holderStackView)
        holderStackView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.top.equalTo(emailInputTextField.snp.bottom).offset(10)
        }
        
        holderStackView.addArrangedSubviews([firstNameTextField, lastNameTextField])
        
        contentView.addSubview(accauntCreatedLabel)
        accauntCreatedLabel.snp.makeConstraints {
            $0.top.equalTo(holderStackView.snp.bottom).offset(10)
            $0.height.equalTo(20)
            $0.left.equalToSuperview().offset(16)
        }
        
        contentView.addSubview(checkBoxHolderView)
        checkBoxHolderView.snp.makeConstraints {
            $0.top.equalTo(holderStackView.snp.bottom).offset(10)
            $0.height.equalTo(20)
            $0.left.equalToSuperview().offset(16)
        }
        
        checkBoxHolderView.addSubview(userAgreesCheckboxButton)
        userAgreesCheckboxButton.snp.makeConstraints {
            $0.width.height.equalTo(18)
            $0.left.equalToSuperview().offset(10)
        }
        
        checkBoxHolderView.addSubview(userAgreesLabel)
        userAgreesLabel.snp.makeConstraints {
            $0.left.equalTo(userAgreesCheckboxButton.snp.left).offset(25)
            $0.centerX.equalToSuperview()
        }
        
        checkBoxHolderView.addSubview(userAgreeButton)
        userAgreeButton.snp.makeConstraints {
            $0.left.equalTo(userAgreesCheckboxButton.snp.left).offset(65)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(110)
            $0.height.equalTo(20)
        }
        
        contentView.addSubview(addCardManuallyButton)
        addCardManuallyButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-50)
            $0.left.equalToSuperview().offset(0)
            $0.right.equalToSuperview().offset(0)
        }
        
        contentView.addSubview(choiceOtherSigninContainerStackView)
        choiceOtherSigninContainerStackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(addCardManuallyButton.snp.top).offset(-10)
            $0.left.equalToSuperview().offset(0)
            $0.right.equalToSuperview().offset(0)
        }

        let leftSideSnakeImageView = UIImageView(image: R.image.icons.snake_line())
        let rightSideSnakeImageView = UIImageView(image: R.image.icons.snake_line())
        
        choiceOtherSigninContainerStackView.addArrangedSubviews([
            leftSideSnakeImageView,
            orContinueWithOtherLabel,
            rightSideSnakeImageView
        ])
        
        contentView.addSubview(applePayBtn)
        applePayBtn.snp.makeConstraints {
            $0.left.equalToSuperview().offset(13)
            $0.right.equalToSuperview().offset(-13)
            $0.bottom.equalTo(choiceOtherSigninContainerStackView.snp.top).offset(-10)
        }
        
        contentView.addSubview(subscribeLabel)
        subscribeLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(applePayBtn.snp.top).offset(-10)
        }
        
        contentView.addSubview(moneyBackView)
        moneyBackView.snp.makeConstraints {
            $0.bottom.equalTo(subscribeLabel.snp.top).offset(-20)
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
        }
    }
    
    func userAgreementConfigure() {
       let tap = UITapGestureRecognizer(target: self, action: #selector(userAgreementAction))
        self.userAgreeButton.addTarget(self, action: #selector(userAgreementAction), for: .allEvents)
        userAgreesLabel.isUserInteractionEnabled = true
        userAgreesLabel.addGestureRecognizer(tap)
    }
    
    @objc func userAgreementAction(_ tapGesture: UITapGestureRecognizer) {
        let webViewController = UIViewController()
        let webView = WKWebView(frame: CGRect(x: 0, y: 100, width: webViewController.view.frame.width, height: webViewController.view.frame.height - 50))
        let url = URL(string: "https://www.keep.pet/terms-and-conditions/")!
        let request = URLRequest(url: url)
        webView.load(request)

        webViewController.view.addSubview(webView)
        self.navigationController?.pushViewController(webViewController, animated: true)
    }
    
    func makeRequestToRegister() -> Observable<Result<Void, ResultErrorType>> {
        let firstName = PaymentDataCollector.shared.name ?? ""
        let secondName = PaymentDataCollector.shared.surname ?? ""
        self.accountManager.input.userEmail = PaymentDataCollector.shared.email
        
        return self.accountManager.input
            .register(with: firstName,
                      lastName: secondName)
            .catchAndReturn(.failure(.unknow))
    }
    
    func makeRequestToEditProfile() -> Observable<Result<Void, ResultErrorType>> {
        let email = PaymentDataCollector.shared.email!
        let firstName = self.firstNameTextField.inputTextField.text
        let secondName = self.lastNameTextField.inputTextField.text
        print(firstName, secondName)
        
//        if firstName!.isEmpty || secondName!.isEmpty {
//            self.showAlertwithTitle(title: "Error", message: "Fill name and lastname")
//        }
//        
        return self.accountManager.input.editUserProfile(with: email,
                                                         name: firstName!,
                                                         surname: secondName!)
        .catchAndReturn(.failure(.mailVerify))
    }
    
    func editUserData() {
        makeRequestToEditProfile().subscribe { [weak self] response in
            
        }
    }
    
    func setupSteps() {
        makeRequestToRegister().subscribe { [weak self] response in
            switch response {
            case .success:
                print("Success created")
                self?.accauntCreatedLabel.isHidden = false
                self?.checkBoxHolderView.isHidden = true
                self?.subscribeLabel.text = "Subscribe & Start Free Trial"

            case .failure(let message):
                self?.showAlertwithTitle(title: "Error", message: message.localizedDescription)
            }
        }
    }
    
    func checkForField() -> Bool {
        guard let firstName = firstNameTextField.inputTextField.text,
              let lastName = lastNameTextField.inputTextField.text,
              let email = emailInputTextField.inputTextField.text else {
            return false
        }
       
        PaymentDataCollector.shared.email = email
        PaymentDataCollector.shared.name = firstName
        PaymentDataCollector.shared.surname = lastName
        let isFirstNameValid = firstName.count >= 2
        let isLastNameValid = lastName.count >= 2
        let isEmailValid = email.isValidEmail()
        let isUserAgreed = userAgreesCheckboxButton.isChecked

        return isFirstNameValid && isLastNameValid && isEmailValid && isUserAgreed
    }
    
    

    
    @objc func tappedAddCardManually() {
        if checkForField() {
            let myString = UserDefaults.standard.string(forKey: "userAccessToken")
            if myString == nil {
                self.setupSteps()
            }else {
                self.editUserData()
            
            }
            let vc = PayWallPaymentViewFactoryViewFactory.create()
            self.navigationController?.pushViewController(vc, animated: true)
        }else {
            self.showAlertwithTitle(title: "Error", message: "Please fill in a inputs")
        }
    }
    
    @objc func tappedApplePay() {
        if checkForField() {
            let vc = ApplePayViewFactory.create()
            vc.delegate = self
            self.present(vc, animated: false)
        } else {
            self.showAlertwithTitle(title: "Error", message: "Please fill in a inputs")
        }
    }
}

class MoneyBackView: BaseView {
    
    // MARK: - UI
    private let baseView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let moneyBackImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "moneyback_icon")
        
        return imageView
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()

    override func configure() {
       
        addSubview(baseView)
        baseView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(100)
        }
        baseView.addSubview(moneyBackImageView)
        moneyBackImageView.snp.makeConstraints {
            $0.right.equalToSuperview().offset(-20)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(80)
            $0.height.equalTo(80)
        }
        
        baseView.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().offset(26)
            $0.right.equalTo(moneyBackImageView.snp.left).offset(-15)
        }
        setupDescriptionLabel(price: PaymentDataCollector.shared.subscriptionPrice ?? "0")
    }
    
    private func setupDescriptionLabel(price: String) {
        let fullText = "Subscription starts after 7 days at \(price) per month"
        let attributedText = NSMutableAttributedString(string: fullText)
        
        // Set the default font and color for the entire text
        attributedText.addAttribute(.font, value: UIFont.systemFont(ofSize: 20), range: NSRange(location: 0, length: fullText.count))
        attributedText.addAttribute(.foregroundColor, value: UIColor.black, range: NSRange(location: 0, length: fullText.count))
        
        // Set different font weights for specific parts of the text
        let boldFont = UIFont.boldSystemFont(ofSize: 20)
        let after7Range = (fullText as NSString).range(of: "after 7 days")
        let priceRange = (fullText as NSString).range(of: price)
        
        attributedText.addAttribute(.font, value: boldFont, range: after7Range)
        attributedText.addAttribute(.font, value: boldFont, range: priceRange)
        
        descriptionLabel.attributedText = attributedText
    }
}
