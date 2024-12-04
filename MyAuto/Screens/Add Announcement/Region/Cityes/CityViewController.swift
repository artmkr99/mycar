//
//  RegionController.swift
//  MyAuto
//
//  Created by User on 19.11.24.
//

import UIKit
import RxSwift

class CityViewController: UIViewController {

    var viewModel: CityViewModel!

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CarMarkModelCell.self)
        return tableView
    }()

    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindRx()
    }

    func setupUI() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.backgroundColor = .red
    }

  func bindRx() {
    viewModel.modelsTableDataSource.asObservable()
      .bind(to: tableView.rx.items) { (table, row, item) in
        let indexPath = IndexPath(row: row, section: 0)
        let cell = table.dequeue(CarMarkModelCell.self, indexPath: indexPath)
        cell.markLabel.text = item.countryName

        return cell
      }.disposed(by: bag)

    tableView.rx.modelSelected(Cityes.self)
      .subscribe(onNext: { [weak self] model in

        CarAnnouncementCollector.shared.region?.append(", \(model.countryName)")
        AnnouncementDataCollectorManager.shared.country = (model.id)
        AnnouncementDataCollectorManager.shared.countryName = model.countryName


        self?.navigationController?.popToRootViewController(animated: true)
      })
      .disposed(by: disposeBag)
  }
}

