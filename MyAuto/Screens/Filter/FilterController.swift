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

    private let tableView = UITableView(frame: .zero, style: .grouped)
    private let disposeBag = DisposeBag()

    typealias FilterSectionModel = RxTableViewSectionedReloadDataSource<SectionModel<FilterSection, FilterItem>>

    private var dataSource: FilterSectionModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindTableView()
    }

    private func setupUI() {
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { $0.edges.equalToSuperview() }
        tableView.register(FilterDetailTableCell.self)
    }

    private func bindTableView() {
        dataSource = FilterSectionModel(configureCell: { _, tableView, indexPath, item in
            switch item {
            case .region(let name), .parameter(let name):
              let cell = tableView.dequeue(FilterDetailTableCell.self, indexPath: indexPath)
              cell.textLabel?.text = name
              return cell

            }
        })

        viewModel.tableDataSource
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)

        tableView.rx.modelSelected(FilterItem.self)
            .bind(to: viewModel.tappedItem)
            .disposed(by: disposeBag)
    }
}

