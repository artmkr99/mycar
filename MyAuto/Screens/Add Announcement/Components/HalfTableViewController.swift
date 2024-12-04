//
//  HalfTableViewController.swift
//  MyAuto
//
//  Created by User on 02.05.24.
//

import UIKit

enum HalfTableViewType {
    case gearType
    case fuelType
    case bodyType
    case changeType
}

protocol HalfTableControllerDelegate: AnyObject {
  func didSelectItem()
}

class HalfTableViewController: UIViewController {
    
    // MARK: - Properties
    var viewModel: HalfTableViewViewModel!
    weak var delegate: HalfTableControllerDelegate?

    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        //view.layer.cornerRadius = 16
        view.clipsToBounds = true
        return view
    }()
    
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.register(CarMarkModelCell.self)

        return tableView
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .gray
        button.setTitle("close", for: .normal)
        return button
    }()
   
    let maxDimmedAlpha: CGFloat = 0.6
    lazy var dimmedView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = maxDimmedAlpha
        return view
    }()
    
    let defaultHeight: CGFloat = 300
    var containerViewHeightConstraint: NSLayoutConstraint?
    var containerViewBottomConstraint: NSLayoutConstraint?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        registerForKeyboardNotifications()
        setupTapGesture()
        bindTableView()
        setupCloseButton()
    }
    
    deinit {
        unregisterForKeyboardNotifications()
    }
    
    // MARK: - Setup
    
    func bindTableView() {
      viewModel.tableDataSource.asObservable()
        .bind(to: tableView.rx.items) { (table, row, item) in
          let indexPath = IndexPath(row: row, section: 0)
          let cell = table.dequeue(CarMarkModelCell.self, indexPath: indexPath)
          cell.markLabel.text = item

          return cell
        }.disposed(by: bag)

      tableView.rx.modelSelected(String.self)
        .subscribe(onNext: { [weak self] item in
          guard let self = self else { return }
          print(CarAnnouncementCollector.shared.carIsChange)
          self.viewModel.selectedItem.onNext(item)
          //CarAnnouncementCollector.shared.carBodyType = item
          self.delegate?.didSelectItem()

          self.dismiss(animated: true)
        })
        .disposed(by: bag)
    }
    
    func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        dimmedView.addGestureRecognizer(tapGesture)
        dimmedView.isUserInteractionEnabled = true
    }
    
    func setupCloseButton() {
        closeButton.addTarget(self, action: #selector(tappedCloseButton), for: .touchUpInside)
    }
    
    @objc func tappedCloseButton() {
      self.dismiss(animated: true)
    }
    
    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        dismiss(animated: false, completion: nil)
    }
    
    func setupView() {
        view.backgroundColor = .clear
    }
    
    func setupConstraints() {
        view.addSubview(dimmedView)
        view.addSubview(containerView)
        containerView.addSubview(tableView)
        dimmedView.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dimmedView.topAnchor.constraint(equalTo: view.topAnchor),
            dimmedView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            dimmedView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dimmedView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        containerView.addSubview(closeButton)
        closeButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(5)
            $0.right.equalToSuperview().offset(-10)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(closeButton.snp.bottom).offset(5)
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        containerViewHeightConstraint = containerView.heightAnchor.constraint(equalToConstant: defaultHeight)
        containerViewBottomConstraint = containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        containerViewHeightConstraint?.isActive = true
        containerViewBottomConstraint?.isActive = true

    }
    
    // MARK: - Keyboard Handling
    
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func unregisterForKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
            return
        }
        let keyboardHeight = keyboardFrame.height
        containerViewBottomConstraint?.constant = -keyboardHeight
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        containerViewBottomConstraint?.constant = 0
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
}
