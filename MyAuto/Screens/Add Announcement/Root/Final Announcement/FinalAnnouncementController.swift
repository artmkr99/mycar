//
//  FinalAnnouncementController.swift
//  MyAuto
//
//  Created by User on 17.05.24.
//

import UIKit

class FinalAnnouncementController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .green
        tableView.register(PhotoCarInfoCell.self)
        tableView.register(CarInfoTableCell.self)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        tableView.delegate = self
        tableView.dataSource = self
    }

    func setupUI() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeue(PhotoCarInfoCell.self, indexPath: indexPath)
            return cell
        }else {
            let cell = tableView.dequeue(CarInfoTableCell.self, indexPath: indexPath)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
}
