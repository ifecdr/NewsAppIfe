//
//  FeaturedViewController.swift
//  NewsApp
//
//  Created by MAC Consultant on 4/1/19.
//  Copyright © 2019 Ifeoluwa Adesida. All rights reserved.
//

import UIKit

class FeaturedViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        viewModel.delegate = self
        viewModel.getHeadlines()
    }
    

}

extension FeaturedViewController: UITableViewDelegate {
    
}

extension FeaturedViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let firstSection = viewModel.articleHeadlines.isEmpty ? 0 : 1
        return section == 0 ? firstSection : viewModel.articleHeadlines.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
}

extension FeaturedViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        <#code#>
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
    
    
}


extension FeaturedViewController: ViewModelDelegate {
    func updateView() {
        <#code#>
    }
    
    
}
