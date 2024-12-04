//
//  HomeViewController.swift
//  MyAuto
//
//  Created by User on 02.04.24.
//

import UIKit

class HomeViewController: UIViewController {

  var viewModel: HomeViewModel?
  
  private let tableView: UITableView = {
    let tableView = UITableView()
    tableView.register(HomeHolderCell.self)
    tableView.register(FilterTableCell.self)
    tableView.separatorColor = .clear
    
    return tableView
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .red
    bindRx()
    setupUI()
    self.navigationController?.navigationBar.backgroundColor = .green

  }

  override func viewDidAppear(_ animated: Bool) {
    rxSubscribe()
  }

  func setupUI() {
    view.addSubview(tableView)
    tableView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }

  func bindRx() {
    viewModel?.tableDataSource.asObservable()
      .bind(to: tableView.rx.items) { (table, row, item) in
        let indexPath = IndexPath(row: row, section: 0)
        if row == 0 {
          let cell = table.dequeue(FilterTableCell.self, indexPath: indexPath)
          return cell

        }

        let cell = table.dequeue(HomeHolderCell.self, indexPath: indexPath)
        cell.fill(data: item)

        return cell
      }.disposed(by: bag)

//    tableView.rx.modelSelected(CarBrandModel.self)
//      .subscribe(onNext: { [weak self] brand in
//        let selectedBrandID = brand.id
//        self?.viewModel.selectedBrandID.onNext(selectedBrandID)
//        CarAnnouncementCollector.shared.carBrand = brand.cyrillicName
//        AnnouncementDataCollectorManager.shared.mark = "\(brand.id)"
//
//        self?.setupToGoModels(model: brand.id)
//      })
//      .disposed(by: disposeBag)
    tableView.rx.itemSelected
      .subscribe { item in
        print(item)
        let vc = FilterViewFactory.create()
        self.navigationController?.pushViewController(vc, animated: true)
      }.disposed(by: bag)
  }

  func rxSubscribe() {
    viewModel?.isLoading.asObservable()
      .bind(to: isLoading(for: self.tableView))
      .disposed(by: bag)
  }
}

//extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
//  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//    return 30
//  }
//  
//  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//    if indexPath.row == 0 {
//      let cell = tableView.dequeue(FilterTableCell.self, indexPath: indexPath)
//      return cell
//    }else {
//      let cell = tableView.dequeue(HomeHolderCell.self, indexPath: indexPath)
//      return cell
//    }
//  }
//  
//  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//    if indexPath.row == 0 {
//      return 140
//    }
//    return self.view.frame.height / 2.2
//  }
//}
