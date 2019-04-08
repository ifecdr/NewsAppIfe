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
    @IBOutlet weak var filteredCollection: UICollectionView!
    @IBOutlet weak var topViewConnstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomViewConstaint: NSLayoutConstraint!
    @IBOutlet weak var topTableConstraint: NSLayoutConstraint!
    
    let viewModel = ViewModel()
    let fireViewModel = FireViewModel()
    var searchKeyword = ""
    var isFavorite: Bool = true
    var isFilterSearch = true
    
    var lastContentOffSet: CGFloat = 0
    //var collectionIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        viewModel.delegate = self
        firebaseObserver()
        fireViewModel.getFirebase()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        fireViewModel.getFirebase()
    }
    
    func goToDetail() {
        
        let storyboard = UIStoryboard(name: "Third" , bundle: Bundle.main)
        let detailVC = storyboard.instantiateViewController(withIdentifier: DetailViewController.identifier) as! DetailViewController
        
        
        let index = tableView.indexPathForSelectedRow?.row
        switch isFilterSearch {
        case true:
            if isFavorite {
                detailVC.id = fireViewModel.article[index!].source.id
                detailVC.image = fireViewModel.article[index!].urlToImage
                detailVC.titleText = fireViewModel.article[index!].title
                detailVC.desc = fireViewModel.article[index!].description
                detailVC.source = fireViewModel.article[index!].source.name
                detailVC.author = fireViewModel.article[index!].author
                detailVC.published = fireViewModel.article[index!].publishedAt
                detailVC.content = fireViewModel.article[index!].content
                detailVC.isFavorite = true
            } else {
                detailVC.image = viewModel.filteredArticle[index!].urlToImage
                detailVC.titleText = viewModel.filteredArticle[index!].title
                detailVC.desc = viewModel.filteredArticle[index!].description
                detailVC.source = viewModel.filteredArticle[index!].source.name
                detailVC.author = viewModel.filteredArticle[index!].author
                detailVC.published = viewModel.filteredArticle[index!].publishedAt
                detailVC.content = viewModel.filteredArticle[index!].content
            }
            
        case false:
            detailVC.image = viewModel.articleEverything[index!].urlToImage
            detailVC.titleText = viewModel.articleEverything[index!].title
            detailVC.desc = viewModel.articleEverything[index!].description
            detailVC.source = viewModel.articleEverything[index!].source.name
            detailVC.author = viewModel.articleEverything[index!].author
            detailVC.published = viewModel.articleEverything[index!].publishedAt
            detailVC.content = viewModel.articleEverything[index!].content
        }
        
        
        
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    
    @objc func firebaseUpdate() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }
    
    func firebaseObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(firebaseUpdate), name: Notification.Name("updateFire"), object: nil)
    }

}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        goToDetail()
    }
}
extension SearchViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch isFilterSearch {
        case true:
            if isFavorite {
                return fireViewModel.article.count
            } else {
                return viewModel.filteredArticle.count
            }
            
        case false:
            return viewModel.articleEverything.count
        }
    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//
//        return viewModel.source[collectionIndex]
//
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as! SearchTableViewCell
        switch isFilterSearch {
        case true:
            if isFavorite{
                cell.configure(article: fireViewModel.article[indexPath.row])
            } else {
                cell.configure(article: viewModel.filteredArticle[indexPath.row])
            }
            
        case false:
            cell.configure(article: viewModel.articleEverything[indexPath.row])
        }
        return cell
        
    }
    
    
}

extension SearchViewController: UICollectionViewDelegate {
    //Collection got selected
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.searchKeyword != "" {
            //collectionIndex = indexPath.row
            self.isFilterSearch = true
            if indexPath.row == 0 {
                self.isFavorite = true
                fireViewModel.getFirebase()
            } else {
                self.isFavorite = false
                viewModel.getfilteredResult(searchKeyword, viewModel.source[indexPath.row])
            }
            
        }
    }
}

extension SearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.source.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = filteredCollection.dequeueReusableCell(withReuseIdentifier: SearchFilteredCollectionViewCell.identifier, for: indexPath) as! SearchFilteredCollectionViewCell
        cell.configure(image: viewModel.sourceImg[indexPath.row] )
        return cell
    }
    
    
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        let searchKeyword = searchText.replacingOccurrences(of: " ", with: "+")
        self.searchKeyword = searchKeyword
        self.isFilterSearch = false
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


