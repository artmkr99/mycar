//
//  ElectCarYearViewModel.swift
//  MyAuto
//
//  Created by User on 22.04.24.
//

import RxSwift


class SelectCarYearViewModel {
    
    let carYearsSubject = BehaviorSubject<[String]>(value: [])
    var yearFrom: String
    var yearTo: String
    
    init(yearFrom: String, yearTo: String) {
        self.yearFrom = yearFrom
        self.yearTo = yearTo
        fetchCarYears()
    }
    
    func fetchCarYears() {
           var startYear: Int
           var endYear: Int
           
           // Convert yearFrom to integer
           guard let fromYear = Int(yearFrom) else {
               // Handle invalid input or conversion failure
               return
           }
           
           // If yearTo is nil, empty, or 0, set it to the current year
           if let toYear = Int(yearTo), toYear > 0 {
               endYear = toYear
           } else {
               endYear = Calendar.current.component(.year, from: Date())
           }
           
           startYear = fromYear
           
           // Generate an array of years from startYear to endYear
           let carYears = (startYear...endYear).map { String($0) }
           
           // Update the BehaviorSubject with the generated array
           carYearsSubject.onNext(carYears)
       }

}
