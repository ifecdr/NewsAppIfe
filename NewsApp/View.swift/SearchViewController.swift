//
//  SearchViewController.swift
//  NewsApp
//
//  Created by MAC Consultant on 4/1/19.
//  Copyright © 2019 Ifeoluwa Adesida. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var filterControlView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    let viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        viewModel.delegate = self
    }

}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
extension SearchViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.articleEverything.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as! SearchTableViewCell
        cell.configure(article: viewModel.articleEverything[indexPath.row])
        return cell
        
    }
    
    
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let searchKeyword = searchText.replacingOccurrences(of: " ", with: "+")
        
        if !searchKeyword.isEmpty {
            viewModel.getSearchResult(searchKeyword)
        }
    }
}

extension SearchViewController: ViewModelDelegate {
    func updateView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            print("Search table Views Reloaded")
        }
    }
    
}
