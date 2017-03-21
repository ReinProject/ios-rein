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
        DispatchQueue(label: "background").async {
            let realm = try! Realm()
            if !User.userExists(inRealm: realm) {
                user.insert(toRealm: realm)
            }
        }
        
    }
    
    // MARK: - View
    
    private struct Storyboard {
        static let ShowMainScreen = "ShowMainScreenSegue"
    }
    
    var userExists: Bool? {
        didSet {
            if userExists == true {
                performSegue(withIdentifier: Storyboard.ShowMainScreen, sender: self)
            } else {
                setScreenEnterData()
            }
        }
    }
    
    var textFieldsAreEmpty: Bool {
        print(usernameTextField.text!)
        if usernameTextField.text == nil && emailTextField.text == nil && maddrTextField.text == nil {
            return true
        } else {
            return false
        }
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    @IBOutlet weak var loginButton: UIButton!
    
    @IBAction func performLogin(_ sender: UIButton) {
        if !textFieldsAreEmpty {
            addUser()
            performSegue(withIdentifier: Storyboard.ShowMainScreen, sender: sender)
        } else {
            let alertController = UIAlertController(title: "Please fill in the text fields", message: nil, preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }

    }
    
    private func setScreenEnterData() {
        usernameTextField.isHidden = false
        emailTextField.isHidden = false
        maddrTextField.isHidden = false
        loginButton.titleLabel?.text = "Log In"
    }
    
    private func setScreenLoading() {
        usernameTextField.isHidden = true
        emailTextField.isHidden = true
        maddrTextField.isHidden = true
        loginButton.isHidden = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue(label: "background").async {
            [weak weakSelf = self] in
            let realm = try! Realm()
            weakSelf?.userExists = User.userExists(inRealm: realm)
        }
        setScreenLoading()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let destVC = segue.destination as? UITabBarController,
//            let destVC2 = destVC.viewControllers?[0] as? UINavigationController,
//             let _ = destVC2.visibleViewController as? JobsTableViewController,
//              segue.identifier == Storyboard.ShowMainScreen {
//                    }
    }
}
