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
    //var imageReuse: [UIImage]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.rowHeight = UITableView.automaticDimension
        viewModel.delegate = self
        viewModel.getHeadlines(viewModel.countryCode.first!)
    }
    
    
    func goToDetail() {
        
        let storyboard = UIStoryboard(name: "Third" , bundle: Bundle.main)
        let detailVC = storyboard.instantiateViewController(withIdentifier: DetailViewController.identifier) as! DetailViewController
        
        //let detail = detailVC.topViewController as! DetailViewController
        let index = tableView.indexPathForSelectedRow?.row
        
        detailVC.image = viewModel.articleHeadlines[index!].urlToImage
        detailVC.titleText = viewModel.articleHeadlines[index!].title
        detailVC.desc = viewModel.articleHeadlines[index!].description
        detailVC.source = viewModel.articleHeadlines[index!].source.name
        detailVC.author = viewModel.articleHeadlines[index!].author
        detailVC.published = viewModel.articleHeadlines[index!].publishedAt
        detailVC.content = viewModel.articleHeadlines[index!].content
        
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    

}

extension FeaturedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ? 50 : 320
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.getHeadlines(viewModel.countryCode[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //imageReuse = tableView.indexPathForSelectedRow?.row
        goToDetail()
    }
}

extension FeaturedViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let firstSection = 1 //viewModel.articleHeadlines.isEmpty ? 0 : 1
        return section == 0 ? firstSection : viewModel.articleHeadlines.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //create a cell from the tablecell class and configure with an index of data in the viewModel
        let cell = tableView.dequeueReusableCell(withIdentifier: FeaturedTableViewCell.identifier[indexPath.section], for: indexPath) as! FeaturedTableViewCell
        switch indexPath.section {
        case 0:
            cell.collectionView.reloadData()
        case 1:
            cell.configure(article: viewModel.articleHeadlines[indexPath.row])
        default:
            break
        }
        
        return cell
    }
    
    
}

extension FeaturedViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.countries.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // create cell and return for each item in the array
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeaturedCollectionViewCell.identifier, for: indexPath) as! FeaturedCollectionViewCell
        cell.configure(countryText: viewModel.countries[indexPath.row])
        return cell
    }
}


extension FeaturedViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 96, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}


extension FeaturedViewController: ViewModelDelegate {
    func updateView() {
        
        DispatchQueue.main.async {
            
            self.tableView.reloadData()
            print("table Views Reloaded")
        }
    }
    
    
}
