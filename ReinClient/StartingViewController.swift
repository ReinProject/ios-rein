//
//  StartingViewController.swift
//  ReinClient
//
//  Created by Alex on 3/7/17.
//  Copyright © 2017 ads2alpha. All rights reserved.
//

import UIKit
import RealmSwift

class StartingViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - Model
    
    private func addUser() {
        let user = User()
        user.email = emailTextField.text!
        user.username = usernameTextField.text!
        user.maddr = maddrTextField.text!
        user.insert(dispatchTo: "userInitiated") {
            [weak self = self] userExists in
            self?.userExists = userExists
        }
    }
    
    var user: User?
    
    var userExists: Bool? {
        didSet {
            if userExists == true {
                setScreenLoading()
                // Do this on main to ensure user's thread safety for segueing. Should probably fix it in the next patch with an optimal solution.
                DispatchQueue.main.async {
                    let realm = try! Realm()
                    let user = realm.objects(User.self).first!
                    self.user = user
                    self.performSegue(withIdentifier: Storyboard.ShowMainScreen, sender: self)
                }
            }
        }
    }
    
    // MARK: - View
    
    override func viewDidLoad() {
        super.viewDidLoad()
        User.userExists(dispatchTo: "userInitiated") {
            [weak self = self] userExists in
            self?.userExists = userExists
        }
    }
    
      // MARK: - Storyboard
    
    private struct Storyboard {
        static let ShowMainScreen = "ShowMainScreenSegue"
    }
    
    @IBOutlet weak var usernameTextField: UITextField! {
        didSet {
            usernameTextField.delegate = self
        }
    }
    
    @IBOutlet weak var emailTextField: UITextField! {
        didSet {
            emailTextField.delegate = self
        }
    }
    
    @IBOutlet weak var maddrTextField: UITextField! {
        didSet {
            maddrTextField.delegate = self
        }
    }
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var fieldsStackView: UIStackView!

      // MARK: - Actions
    
    @IBAction func performLogin(_ sender: UIButton) {
        if !textFieldsAreEmpty && !userExists! {
            addUser()
        } else {
            let alertController = UIAlertController(title: "Please fill in the text fields.", message: nil, preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }

    }
    
    var textFieldsAreEmpty: Bool {
        if usernameTextField.text == nil && emailTextField.text == nil && maddrTextField.text == nil {
            return true
        } else {
            return false
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    private func setScreenLoading() {
        fieldsStackView.isHidden = true
        loginButton.titleLabel?.text = "Continue"
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Storyboard.ShowMainScreen {
            if let dvc1 = segue.destination as? UITabBarController,
                let dvc2 = dvc1.viewControllers?[0] as? UINavigationController,
                let dvc3 = dvc2.visibleViewController as? JobsTableViewController {
                dvc3.user = user
            }
        }
    }

}
