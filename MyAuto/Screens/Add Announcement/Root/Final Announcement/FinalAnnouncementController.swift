//
//  FinalAnnouncementController.swift
//  MyAuto
//
//  Created by User on 17.05.24.
//

import UIKit

class FinalAnnouncementController: UIViewController, UITableViewDelegate, UITableViewDataSource {

  var viewModel: FinalAnnouncementViewModel!

  private let tableView: UITableView = {
    let tableView = UITableView()
    tableView.backgroundColor = .green
    tableView.register(PhotoCarInfoCell.self)
    tableView.register(CarInfoTableCell.self)
    return tableView
  }()

  private let addAnnouncementButton: UIButton = {
    let button = UIButton()
    button.titleLabel?.text = "Add announcement"
    button.backgroundColor = .red
    button.addTarget(self, action: #selector(tappedAddAnnouncemet), for: .touchUpInside)

    return button
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    tableView.delegate = self
    tableView.dataSource = self
  }

  override func viewWillAppear(_ animated: Bool) {
    let carDetails: [String: String] = [
      "Brand": CarAnnouncementCollector.shared.carBrand,
      "Model": CarAnnouncementCollector.shared.carModel,
      "Year": CarAnnouncementCollector.shared.carYear,
      "Millage": CarAnnouncementCollector.shared.carMillage,
      "Price": CarAnnouncementCollector.shared.carPrice,
      "Color": CarAnnouncementCollector.shared.carColor,
      "Body Type": CarAnnouncementCollector.shared.carBodyType,
      "Gear Type": CarAnnouncementCollector.shared.carGearType,
      "Fuel Type": CarAnnouncementCollector.shared.carFuelType,
      "Is Change": CarAnnouncementCollector.shared.carIsChange,
      "Engine Size": CarAnnouncementCollector.shared.carEngineSize
    ].compactMapValues { $0 }

  }

  func setupUI() {
    view.addSubview(tableView)
    tableView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }

    view.addSubview(addAnnouncementButton)
    addAnnouncementButton.snp.makeConstraints {
      $0.bottom.equalToSuperview().offset(-10)
      $0.left.equalToSuperview().offset(10)
      $0.right.equalToSuperview().offset(10)
      $0.height.equalTo(30)
    }
  }

  @objc func tappedAddAnnouncemet() {
    viewModel.createAnnouncement()
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if indexPath.row == 0 {
      let cell = tableView.dequeue(PhotoCarInfoCell.self, indexPath: indexPath)
      return cell
    }else if indexPath.row == 1 {
      let cell = tableView.dequeue(CarInfoTableCell.self, indexPath: indexPath)
      return cell
    }else {
      let cell = UITableViewCell()
      cell.backgroundColor = .red
      return cell
    }
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 3
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
   
    if indexPath.row == 2 {
      tappedAddAnnouncemet()
    }
  }
}
