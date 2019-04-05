//
//  LopginViewController.swift
//  NewsApp
//
//  Created by Ifeoluwa Adesida on 3/30/19.
//  Copyright © 2019 Ifeoluwa Adesida. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var loginVIew: UIView!
    @IBOutlet weak var loginStack: UIStackView!
    @IBOutlet weak var loginViewTopC: NSLayoutConstraint!
    @IBOutlet weak var loginViewBottomC: NSLayoutConstraint!
    
    var slide: [Slide] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self
        
        slide = createSlides()
        setupSlideScrollView(slides: slide)
        
        editButtons()
        
        self.view.bringSubviewToFront(loginVIew)
        self.view.bringSubviewToFront(loginStack)
        
    }
    
    func editButtons() {
        
        registerButton.layer.cornerRadius = registerButton.layer.frame.height / 2
        signInButton.layer.cornerRadius = signInButton.layer.frame.height / 2
        
        signInButton.layer.borderColor = UIColor.lightGray.cgColor
        signInButton.layer.borderWidth = 1.5
        
    }

    @IBAction func prevAction(_ sender: UIButton) {
        if pageControl.currentPage >= 0 {
            pageControl.currentPage -= 1
            let x = CGFloat(pageControl.currentPage) * scrollView.frame.size.width
            scrollView.setContentOffset(CGPoint(x: x, y: 0), animated: true)
            scrollView.layoutIfNeeded()
            
        } else { return }
    }
    
    @IBAction func nextAction(_ sender: UIButton) {
        if pageControl.currentPage <= slide.count - 1 {
            //increase current page by 1
            pageControl.currentPage += 1
            //find the x by using the current page times width of scroll view
            let x = CGFloat(pageControl.currentPage) * scrollView.frame.size.width
            //offset our scroll view by our x
            scrollView.setContentOffset(CGPoint(x: x, y: 0), animated: true)
            //layout sub views immediatley IF changes are pending
            scrollView.layoutIfNeeded()
            //If the current page is not less than or equal to 2, do nothing
            
            
        } else { return }
    }
    
    @IBAction func registerAction(_ sender: UIButton) {
        guard let userName = username.text, let userPass = password.text, username.hasText, password.hasText else {
            self.showAlert(title: "Error :( ", message: "Invalid Username or Password")
            print("Could Not Verify User Details")
            return
        }
        
        //create a new user and add the user to the firebase auth
        Auth.auth().createUser(withEmail: userName, password: userPass) { (result, error) in
            
            if let e = error {
                
                self.showAlert(title: "Sorry :( ", message: "\(e.localizedDescription)")
                
                print("Could Not Create User: \(e.localizedDescription)")
            }
            
            if let _ = result {
                print("Account Created")
                //self.goToHome()
                
            }
        }
    }
    
    @IBAction func signInAction(_ sender: UIButton) {
        guard let userName = username.text, let userPass = password.text, username.hasText, password.hasText else {
            self.showAlert(title: "Error :( ", message: "Invalid Username or Password")
            print("Could Not Verify User Details")
            return
        }
        
        //authenticate the user
        Auth.auth().signIn(withEmail: userName, password: userPass) { (result, error) in
            
            if let e = error {
                self.showAlert(title: "Sorry :( ", message: "\(e.localizedDescription)")
                print("Could Not Sign In User: \(e.localizedDescription)")
            }
            
            if let _ = result {
                print("SignIn successful")
                //self.goToHome()
                self.performSegue(withIdentifier: "second", sender: self)
            }
        }
    }
    
    
    func setupSlideScrollView(slides: [Slide]) {
        //scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: scrollView.frame.size.height)
        scrollView.contentSize = CGSize(width: view.frame.size.width * CGFloat(slides.count) , height: scrollView.frame.size.height)
        scrollView.isPagingEnabled = true
        
        for i in 0..<slides.count {
            slides[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.size.width, height: scrollView.frame.size.height)
            scrollView.addSubview(slides[i])
        }
     //   loginVIew.bringSubviewToFront(self.scrollView)
        
        
    }
    //TODO: Check for new Images
    func createSlides() -> [Slide] {
        let slide1: Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide1.imageViewer.image = UIImage(named: "newsbackg1")
        //slide1.imageViewer.contentMode = .center
        
        let slide2: Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide2.imageViewer.image = UIImage(named: "newsback2")
        //slide2.imageViewer.contentMode = .center
        
        let slide3: Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide3.imageViewer.image = UIImage(named: "newsback3")
        //slide3.imageViewer.contentMode = .scaleAspectFill
        
        return [slide1, slide2, slide3]
    }
}

extension LoginViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
        pageControl.currentPage = Int(pageIndex)
    }
}


extension LoginViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        //set the contraints of the loginView to move it up the view
        print("editing started")
        loginViewTopC.constant = 333
        loginViewBottomC.constant = 357
        
        UIView.animate(withDuration: 0.9, delay: 0.0, options: .transitionCurlUp, animations: {
            self.view.layoutIfNeeded()
        }) { (animateComplete) in
            print("animation complete")
        }
    }
}
