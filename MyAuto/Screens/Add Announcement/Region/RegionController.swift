//
//  RegionController.swift
//  MyAuto
//
//  Created by User on 19.11.24.
//

import UIKit
import RxSwift

class RegionController: UIViewController {

    var viewModel: RegionViewModel!

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
          cell.markLabel.text = item.regionName

          return cell
        }.disposed(by: bag)

        tableView.rx.modelSelected(Regions.self)
            .subscribe(onNext: { [weak self] model in
              let vc = CityViewFactory.create(cityID: "\(model.id)")
              CarAnnouncementCollector.shared.region = ""
              CarAnnouncementCollector.shared.region?.append(model.regionName)
              AnnouncementDataCollectorManager.shared.region = model.id
              AnnouncementDataCollectorManager.shared.regionName = model.regionName


              self?.navigationController?.pushViewController(vc, animated: true)
            })
            .disposed(by: disposeBag)
    }
}

