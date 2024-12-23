//
//  HomeViewController.swift
//  MyAuto
//
//  Created by User on 02.04.24.
//

import UIKit
import RxSwift

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
    guard let viewModel = viewModel else { return }

      viewModel.newtableDataSource
          .bind(to: tableView.rx.items) { (table, row, item) in
              let indexPath = IndexPath(row: row, section: 0)
              switch item {
              case .filter:
                  let cell = table.dequeue(FilterTableCell.self, indexPath: indexPath)
                  return cell

              case .announcements(let data):
                  let cell = table.dequeue(HomeHolderCell.self, indexPath: indexPath)
                  if let announcement = data.first { // Customize based on your requirements
                      cell.fill(data: announcement)
                  }
                  return cell
              }
          }
          .disposed(by: bag)

//      tableView.rx.itemSelected
//          .subscribe(onNext: { [weak self] indexPath in
//            let vc = FilterViewFactory.create(nav: self?.navigationController as! BaseNavigationController)
//            self?.navigationController!.pushViewController(vc, animated: true)
//            self.viewModel?.itemClicked.ac
//          })
//          .disposed(by: bag)
          tableView.rx.modelSelected(HomeTableItemsModel.self)
           .bind(to: viewModel.itemClicked)
           .disposed(by: bag)
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
