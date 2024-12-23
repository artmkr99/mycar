//
//  CarMarkModelSelectionController.swift
//  MyAuto
//
//  Created by User on 13.04.24.
//

import UIKit
import RxSwift
import RxCocoa

class CarAnnouncementCollector {
  static var shared = CarAnnouncementCollector()

  var carBrand: String?
  var carModel: String?
  var carYear: String?
  var carMillage: String?
  var carPrice: String?
  var carColor: String?
  var carBodyType: String?
  var carGearType: String?
  var carFuelType: String?
  var carIsChange: String?
  var region: String?
  var carEngineSize: String?
  var carImages: [UIImage]?
}

class CarMarkModelSelectionController: UIViewController {

  var viewModel: CarMarkModelViewModel!

  private let tableView: UITableView = {
    let tableView = UITableView()
    tableView.register(CarMarkModelCell.self)
    return tableView
  }()

  private let searchBar: UISearchBar = {
    let searchBar = UISearchBar()
    searchBar.placeholder = "Search car brands..."
    return searchBar
  }()


  private let disposeBag = DisposeBag()

  override func loadView() {
    super.loadView()
    bindRx()
    rxSubscribe()
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }

  override func viewWillAppear(_ animated: Bool) {
    viewModel.getCarBrands()
  }

  func setupUI() {
    tableView.backgroundColor = .red

    view.addSubview(searchBar)
    searchBar.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
      make.leading.trailing.equalToSuperview()
    }

    view.addSubview(tableView)
    tableView.snp.makeConstraints { make in
      make.top.equalTo(searchBar.snp.bottom)
      make.leading.trailing.bottom.equalToSuperview()
    }
  }

  func bindRx() {
    viewModel.brandsTableDataSource.asObservable()
      .bind(to: tableView.rx.items) { (table, row, item) in
        let indexPath = IndexPath(row: row, section: 0)
        let cell = table.dequeue(CarMarkModelCell.self, indexPath: indexPath)
        cell.fill(data: item)

        return cell
      }.disposed(by: bag)

    tableView.rx.modelSelected(CarBrandModel.self)
      .subscribe(onNext: { [weak self] brand in
        let selectedBrandID = brand.id
        self?.viewModel.selectedBrandID.onNext(selectedBrandID)
        CarAnnouncementCollector.shared.carBrand = brand.cyrillicName
        AnnouncementDataCollectorManager.shared.mark = brand.id
        brand.selectedID == brand.id

        self?.setupToGoModels(model: brand.id)
      })
      .disposed(by: disposeBag)
    //
    //        searchBar.rx.text.orEmpty
    //          .debounce(RxTimeInterval.milliseconds(300), scheduler: MainScheduler())
    //          .distinctUntilChanged()
    //          .subscribe(onNext: { [weak self] searchText in
    //            self?.viewModel.filterBrands(searchText: searchText)
    //          })
    //          .disposed(by: disposeBag)
  }

    func rxSubscribe() {
      viewModel.isLoading.asObservable()
        .bind(to: isLoading(for: self.tableView))
        .disposed(by: bag)
    }

    func setupToGoModels(model: Any) {
      let vc = CarModelViewFactory.create(model: model)
      self.navigationController?.pushViewController(vc, animated: true)
    }
}
