//
//  HomeViewModel.swift
//  News
//
//  Created by Omar Mohamed on 29/12/2023.
//

import Foundation
import Combine

class HomeViewModel {
    let headlineNewsProtocol: HeadlineNewsProtocol
    
    @Published var articales = [Article]()
    @Published var error: String?
    
    private var cellViewModels: [NewsCellViewModel] = [NewsCellViewModel]() {
        didSet {
            self.reloadTableViewClosure?()
        }
    }
    var reloadTableViewClosure: (()->())?
    
    var numberOfCells: Int {
        return cellViewModels.count
    }
    
    init(headlineNewsProtocol: HeadlineNewsProtocol = NetworkManager()) {
        self.headlineNewsProtocol = headlineNewsProtocol
    }
    
    func getHeadlineNews() {
        headlineNewsProtocol.getNewsHeadlines { error, headlines in
            if let error = error {
                print(error.localizedDescription)
            }
            
            if let articles = headlines?.articles {
                self.articales = articles
            }
            
            
            for articale in self.articales {
                self.cellViewModels.append(NewsCellViewModel(title: articale.title ?? "", description: articale.description ?? ""))
            }
        }
    }
    
    func getCellViewModel( at indexPath: IndexPath ) -> NewsCellViewModel {
        return cellViewModels[indexPath.row]
    }
}
