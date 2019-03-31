//
//  LopginViewController.swift
//  NewsApp
//
//  Created by Ifeoluwa Adesida on 3/30/19.
//  Copyright © 2019 Ifeoluwa Adesida. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    var slide: [Slide] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self
        
        slide = createSlides()
        setupSlideScrollView(slides: slide)
        
        
    }

    @IBAction func prevAction(_ sender: UIButton) {
    }
    
    @IBAction func nextAction(_ sender: UIButton) {
    }
    
    @IBAction func registerAction(_ sender: UIButton) {
    }
    
    @IBAction func signInAction(_ sender: UIButton) {
    }
    
    
    func setupSlideScrollView(slides: [Slide]) {
        scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 360)
        scrollView.contentSize = CGSize(width: view.frame.width, height: 360)
        scrollView.isPagingEnabled = true
        
        for i in 0..<slides.count {
            slides[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: 360)
            scrollView.addSubview(slides[i])
        }
    }
    
    func createSlides() -> [Slide] {
        let slide1: Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide1.imageViewer.image = UIImage(named: "news1")
        
        let slide2: Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide1.imageViewer.image = UIImage(named: "news2")
        
        let slide3: Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide3.imageViewer.image = UIImage(named: "news3")
        
        return [slide1, slide2, slide3]
    }
}

extension LoginViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
        pageControl.currentPage = Int(pageIndex)
    }
}
