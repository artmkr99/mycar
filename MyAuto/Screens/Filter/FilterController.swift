//
//  FilterController.swift
//  MyAuto
//
//  Created by User on 28.11.24.
//

import UIKit
import RxSwift
import RxDataSources
import SnapKit

class FilterController: UIViewController {
    var viewModel: FilterViewModel!

    private let searchButton: UIButton = {
      let button = UIButton()
      button.setTitle("Search", for: .normal)
      button.backgroundColor = .brown

      return button
    }()

    private let tableView = UITableView(frame: .zero, style: .grouped)
    private let disposeBag = DisposeBag()

    typealias FilterSectionModel = RxTableViewSectionedReloadDataSource<SectionModel<FilterSection, FilterItem>>

    private var dataSources: FilterSectionModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindTableView()
    }

    private func setupUI() {
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { $0.edges.equalToSuperview() }
        tableView.register(FilterDetailTableCell.self)
        tableView.register(MarkModelTableCell.self)
      
        self.view.addSubview(searchButton)
        searchButton.snp.makeConstraints {
          $0.bottom.equalToSuperview().offset(5)
          $0.left.equalToSuperview().offset(10)
          $0.right.equalToSuperview().offset(-10)
          $0.height.equalTo(30)
        }
    }

  func bindTableView() {
      dataSources = FilterSectionModel(configureCell: { dataSource, tableView, indexPath, item in
      let item = dataSource[indexPath]

      switch item {
      case .makeModelYear:
        let cell = tableView.dequeue(MarkModelTableCell.self, indexPath: indexPath)
        cell.cellName.text = item.title
        cell.cellValue.text = CarAnnouncementCollector.shared.carBrand

        return cell

      case .mileage:
        let cell = tableView.dequeue(MarkModelTableCell.self, indexPath: indexPath)
        cell.cellName.text = item.title
        cell.cellValue.text = CarAnnouncementCollector.shared.carMillage

        return cell
      case .color:
        let cell = tableView.dequeue(MarkModelTableCell.self, indexPath: indexPath)
        cell.cellName.text = item.title
        cell.cellValue.text = CarAnnouncementCollector.shared.carColor

        return cell
      case .bodyType:
        let cell = tableView.dequeue(MarkModelTableCell.self, indexPath: indexPath)
        cell.cellName.text = item.title
        cell.cellValue.text = CarAnnouncementCollector.shared.carBodyType

        return cell
      case .engineVolume:
        let cell = tableView.dequeue(MarkModelTableCell.self, indexPath: indexPath)
        cell.cellName.text = item.title
        cell.cellValue.text = CarAnnouncementCollector.shared.carEngineSize

        return cell
      case .gearboxType:
        let cell = tableView.dequeue(MarkModelTableCell.self, indexPath: indexPath)
        cell.cellName.text = item.title
        cell.cellValue.text = CarAnnouncementCollector.shared.carGearType

        return cell
      case .fuelType:
        let cell = tableView.dequeue(MarkModelTableCell.self, indexPath: indexPath)
        cell.cellName.text = item.title
        cell.cellValue.text = CarAnnouncementCollector.shared.carFuelType

        return cell

      case .exchange:
        let cell = tableView.dequeue(MarkModelTableCell.self, indexPath: indexPath)
        cell.cellName.text = item.title
        cell.cellValue.text = CarAnnouncementCollector.shared.carIsChange

        return cell
      case .price:
        let cell = tableView.dequeue(MarkModelTableCell.self, indexPath: indexPath)
        cell.cellName.text = item.title
        cell.cellValue.text = CarAnnouncementCollector.shared.carPrice

        return cell
      case .region:
        let cell = tableView.dequeue(MarkModelTableCell.self, indexPath: indexPath)
        cell.cellName.text = item.title
        cell.cellValue.text = CarAnnouncementCollector.shared.region
        return cell
      }
    })

    tableView.rx.modelSelected(FilterItem.self)
      .bind(to: viewModel.tappedItem)
      .disposed(by: bag)

    viewModel.tableDataSource
      .bind(to: tableView.rx.items(dataSource: dataSources))
      .disposed(by: bag)

    tableView.rx.itemSelected
      .map { (at: $0, animated: true) }
      .subscribe(onNext: tableView.deselectRow)
      .disposed(by: bag)
  }
}

extension FilterController: CustomModalViewControllerDelegate, HalfTableControllerDelegate {

  // MARK: - HalfTableControllerDelegate
  func didSelectItem() {
    self.tableView.reloadData()
  }

 // MARK: - CustomModalViewControllerDelegate
  func didSaveData() {
    self.tableView.reloadData()
  }
}
