//
//  CarColorViewController.swift
//  MyAuto
//
//  Created by User on 29.04.24.
//

import UIKit

struct ColorData {
  let color: UIColor
  let name: String
}

class CarColorViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  var viewModel: CarColorViewModel!

  private let tableView: UITableView = {
    let tableView = UITableView()
    tableView.register(CarColorTableCell.self)
    return tableView
  }()
  
  // Sample data source
  let colorDataArray: [ColorData] = [
    ColorData(color: UIColor(red: 192/255, green: 192/255, blue: 192/255, alpha: 1.0), name: "Silver"),
    ColorData(color: .white, name: "White"),
    ColorData(color: .black, name: "Black"),
    ColorData(color: .blue, name: "Blue"),
    ColorData(color: .cyan, name: "Cyan"),
    ColorData(color: .brown, name: "Brown"),
    ColorData(color: .purple, name: "Purple"),
    ColorData(color: .green, name: "Green"),
    ColorData(color: .red, name: "Red"),
    ColorData(color: .magenta, name: "Magenta"),
    ColorData(color: .orange, name: "Orange"),
    ColorData(color: UIColor(red: 255/255, green: 192/255, blue: 203/255, alpha: 1.0), name: "Pink"),
    ColorData(color: UIColor(red: 245/255, green: 245/255, blue: 220/255, alpha: 1.0), name: "Beige"), // Beige color
    ColorData(color: .yellow, name: "Yellow"),
    ColorData(color: UIColor(red: 255/255, green: 215/255, blue: 0/255, alpha: 1.0), name: "Gold") // Gold color
  ]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    
    tableView.dataSource = self
    tableView.delegate = self

  }
  
  func setupUI() {
    view.addSubview(tableView)
    tableView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return colorDataArray.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeue(CarColorTableCell.self, indexPath: indexPath)
    let colorData = colorDataArray[indexPath.row]
    cell.fill(color: colorData.color, name: colorData.name)
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    CarAnnouncementCollector.shared.carColor = colorDataArray[indexPath.row].name
    AnnouncementDataCollectorManager.shared.colorName = colorDataArray[indexPath.row].name
    AnnouncementDataCollectorManager.shared.colorId = indexPath.row + 1
    self.navigationController?.popViewController(animated: true)
  }
}
