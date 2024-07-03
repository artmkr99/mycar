//
//  SelectCarYearViewFactory.swift
//  MyAuto
//
//  Created by User on 22.04.24.
//

import Foundation

enum SelectCarYearViewFactory {
    static func create(yearFrom: String, yearTo: String?) -> SelectCarYearController {
        let controller = SelectCarYearController()
        let viewModel = SelectCarYearViewModel(yearFrom: yearFrom, yearTo: yearTo ?? "")
        controller.viewModel = viewModel
        
        return controller
    }
}
