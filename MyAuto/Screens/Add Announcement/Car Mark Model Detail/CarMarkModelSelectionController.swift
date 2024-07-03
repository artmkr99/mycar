//
//  CarMarkModelSelectionController.swift
//  MyAuto
//
//  Created by User on 13.04.24.
//

import UIKit
import RxSwift
import RxCocoa

struct CarAnnouncementCollector {
    static var shared = CarAnnouncementCollector()
    
    var carBrand: String?
    var carModel: String?
    var carYear: String?
    var carMillage: String?
    var carPrice: String?
    var carColor: String?
}

class CarMarkModelSelectionController: UIViewController {
  
    var viewModel: CarMarkModelViewModel!

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CarMarkModelCell.self)
        return tableView
    }()
    
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        super.loadView()
        bindRx()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }
    
    func setupUI() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.backgroundColor = .red
    }
    
    func bindRx() {
        viewModel.brandsTableDataSource.asObservable()
            .bind(to: tableView.rx.items) { (table, row, item) in
                let indexPath = IndexPath(row: row, section: 0)
                let cell = table.dequeue(CarMarkModelCell.self, indexPath: indexPath)
                cell.fill(data: item)
    
                return cell
            }.disposed(by: bag)
        
        tableView.rx.modelSelected(Brand.self)
            .subscribe(onNext: { [weak self] brand in
                let selectedBrandID = brand.id
                self?.viewModel.selectedBrandID.onNext(selectedBrandID)
                CarAnnouncementCollector.shared.carBrand = brand.name
                
                self?.setupToGoModels(model: brand.id)
            })
            .disposed(by: disposeBag)
    }
    
    func setupToGoModels(model: String) {
        let vc = CarModelViewFactory.create(model: model)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
