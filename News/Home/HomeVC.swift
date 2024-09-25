//
//  ViewController.swift
//  News
//
//  Created by Omar Mohamed on 29/12/2023.
//

import UIKit
import Combine

class HomeVC: UIViewController {

    @IBOutlet weak var newsTable: UITableView!
    
    lazy var viewModel: HomeViewModel = {
        return HomeViewModel()
    }()
    private var cancellables: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        initView()
        initVM()
    }

    func initView() {
        newsTable.delegate = self
        newsTable.dataSource = self
        newsTable.register(UINib(nibName: "HeadlineNewsCell", bundle: nil), forCellReuseIdentifier: "HeadlineNewsCell")
    }
    
    func initVM() {
        viewModel.$articales.sink { articales in
            DispatchQueue.main.async {
                self.newsTable.reloadData()
            }
        }.store(in: &cancellables)
        
        viewModel.getHeadlineNews()
    }
}

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCells
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HeadlineNewsCell", for: indexPath) as? HeadlineNewsCell else {
            fatalError("Cell not exists in storyboard")
        }
        
        let cellVM = viewModel.getCellViewModel( at: indexPath )
        cell.headlineListCellViewModel = cellVM
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
}
