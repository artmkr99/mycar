//
//  SelectCarYearController.swift
//  MyAuto
//
//  Created by User on 22.04.24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class SelectCarYearController: UIViewController {
    var viewModel: SelectCarYearViewModel!
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CarMarkModelCell.self)
        return tableView
    }()
    
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
        viewModel.carYearsSubject.asObservable()
            .bind(to: tableView.rx.items) { (table, row, item) in
                let indexPath = IndexPath(row: row, section: 0)
                let cell = table.dequeue(CarMarkModelCell.self, indexPath: indexPath)
                cell.markLabel.text = item
                
                return cell
            }.disposed(by: bag)
  
        
        tableView.rx.itemSelected
            .subscribe { [weak self] item in
                guard let cell = self?.tableView.cellForRow(at: item) as? CarMarkModelCell else {
                    return
                }
                let selectedMarkLabelText = cell.markLabel.text
                CarAnnouncementCollector.shared.carYear = selectedMarkLabelText
                self?.navigationController?.popToRootViewController(animated: true)
            }
            .disposed(by: bag)
    }
    
}
