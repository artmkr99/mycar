//
//  CarModelListViewController.swift
//  MyAuto
//
//  Created by User on 22.04.24.
//

import UIKit
import RxSwift
import RxCocoa

class CarModelListViewController: UIViewController {
  
    var viewModel: CarModelListViewModel!

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
                cell.markLabel.text = item.model

                return cell
            }.disposed(by: bag)
        
        tableView.rx.modelSelected(CarModels.self)
            .subscribe(onNext: { [weak self] model in
               // let selectedBrandID = brand.id
                print("Selected brand ID: \(model.yearFrom) - \(model.yearTo)")
                //self?.viewModel.selectedBrandID.onNext(selectedBrandID)
                CarAnnouncementCollector.shared.carModel = model.model
                AnnouncementDataCollectorManager.shared.model = model.id

//                var dd = CarAnnouncementCollectorBuilder.shared
//                    .setCarBrand(model.name)
//                    .build()
//                print(dd)
                //CarAnnouncementCollectorBuilder.shared.setCarModel(model.name)
                //CarAnnouncementCollector.shared.carModel = model.name

                let vc = SelectCarYearViewFactory.create(yearFrom: String(model.yearFrom), yearTo: String(model.yearTo ?? 0))
                self?.navigationController?.pushViewController(vc, animated: true)
                //self?.navigationController?.popToRootViewController(animated: true)
            })
            .disposed(by: disposeBag)
    }
}

//class CarAnnouncementCollectorBuilder {
//    static let shared = CarAnnouncementCollectorBuilder()
//    
//    private var carBrand: String?
//    private var carModel: String?
//    private var carYear: String?
//    
//    @discardableResult
//    func setCarBrand(_ brand: String?) -> CarAnnouncementCollectorBuilder {
//        self.carBrand = brand
//        return self
//    }
//    
//    @discardableResult
//    func setCarModel(_ model: String?) -> CarAnnouncementCollectorBuilder {
//        self.carModel = model
//        return self
//    }
//    
//    @discardableResult
//    func setCarYear(_ year: String?) -> CarAnnouncementCollectorBuilder {
//        self.carYear = year
//        return self
//    }
//    
//    func build() -> CarAnnouncementCollector {
//      return CarAnnouncementCollector
//    }
//}
