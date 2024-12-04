//
//  AddAnnouncementViewController.swift
//  MyAuto
//
//  Created by User on 02.04.24.
//

import UIKit
import RxSwift
import RxDataSources
import SnapKit

class AddAnnouncementViewController: UIViewController, UIScrollViewDelegate {
  var authToken: String?
  var man: UserAccountManager?

  var viewModel: AddAnnouncementViewModel!
  typealias AddAnnouncementSectionModel = RxTableViewSectionedReloadDataSource<SectionModel<AddAnnouncementTableSection, AddAnnouncementTableItems>>

  private var dataSources: AddAnnouncementSectionModel!

  private let tableView: UITableView = {
    let tableView = UITableView.init(frame: .zero, style: .grouped)
    tableView.contentInset.top = 34
    tableView.register(MarkModelTableCell.self)
    tableView.register(CarPhotoButtonTableCell.self)

    return tableView
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    self.view.backgroundColor = .yellow
    bindTableView()
  }

  override func viewWillAppear(_ animated: Bool) {
    self.tableView.reloadData()
  }
}

extension AddAnnouncementViewController: UITableViewDelegate {

  func setupUI() {
    self.view.addSubview(tableView)
    tableView.backgroundColor = .yellow
    tableView.rx.setDelegate(self).disposed(by: bag)

    tableView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }

  func bindTableView() {
    dataSources = AddAnnouncementSectionModel(configureCell: { dataSource, tableView, indexPath, item in
      let item = dataSource[indexPath]

      switch item {
      case .carMark:
        let cell = tableView.dequeue(MarkModelTableCell.self, indexPath: indexPath)
        cell.cellName.text = item.title
        cell.cellValue.text = CarAnnouncementCollector.shared.carBrand

        return cell
      case .carModel:
        let cell = tableView.dequeue(MarkModelTableCell.self, indexPath: indexPath)
        cell.cellName.text = item.title
        cell.cellValue.text = CarAnnouncementCollector.shared.carModel

        return cell
      case .carYear:
        let cell = tableView.dequeue(MarkModelTableCell.self, indexPath: indexPath)
        cell.cellName.text = item.title
        cell.cellValue.text = CarAnnouncementCollector.shared.carYear

        return cell
      case .carMilage:
        let cell = tableView.dequeue(MarkModelTableCell.self, indexPath: indexPath)
        cell.cellName.text = item.title
        cell.cellValue.text = CarAnnouncementCollector.shared.carMillage

        return cell
      case .carColor:
        let cell = tableView.dequeue(MarkModelTableCell.self, indexPath: indexPath)
        cell.cellName.text = item.title
        cell.cellValue.text = CarAnnouncementCollector.shared.carColor

        return cell
      case .carBodyType:
        let cell = tableView.dequeue(MarkModelTableCell.self, indexPath: indexPath)
        cell.cellName.text = item.title
        cell.cellValue.text = CarAnnouncementCollector.shared.carBodyType

        return cell
      case .carEngineSize:
        let cell = tableView.dequeue(MarkModelTableCell.self, indexPath: indexPath)
        cell.cellName.text = item.title
        cell.cellValue.text = CarAnnouncementCollector.shared.carEngineSize

        return cell
      case .carGearType:
        let cell = tableView.dequeue(MarkModelTableCell.self, indexPath: indexPath)
        cell.cellName.text = item.title
        cell.cellValue.text = CarAnnouncementCollector.shared.carGearType

        return cell
      case .carFuelType:
        let cell = tableView.dequeue(MarkModelTableCell.self, indexPath: indexPath)
        cell.cellName.text = item.title
        cell.cellValue.text = CarAnnouncementCollector.shared.carFuelType

        return cell

      case .isChange:
        let cell = tableView.dequeue(MarkModelTableCell.self, indexPath: indexPath)
        cell.cellName.text = item.title
        cell.cellValue.text = CarAnnouncementCollector.shared.carIsChange

        return cell
      case .carPhotos:
        let cell = tableView.dequeue(CarPhotoButtonTableCell.self, indexPath: indexPath)

        return cell
      case .carPrice:
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

    tableView.rx.modelSelected(AddAnnouncementTableItems.self)
      .bind(to: viewModel.tappedToTableItem)
      .disposed(by: bag)

    viewModel.tableDataSource
      .bind(to: tableView.rx.items(dataSource: dataSources))
      .disposed(by: bag)

    tableView.rx.itemSelected
      .map { (at: $0, animated: true) }
      .subscribe(onNext: tableView.deselectRow)
      .disposed(by: bag)
  }

  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let view = SettingsTableHeaderView()
    let headerTitle = self.dataSources[section].model.title
    view.titleLabel.text = headerTitle
    view.backgroundColor = .red
    return view
  }
}

extension AddAnnouncementViewController: CustomModalViewControllerDelegate, HalfTableControllerDelegate {

  // MARK: - HalfTableControllerDelegate
  func didSelectItem() {
    self.tableView.reloadData()
  }

 // MARK: - CustomModalViewControllerDelegate
  func didSaveData() {
    self.tableView.reloadData()
  }
}
