//
//  ViewController.swift
//  firebaseApp
//
//  Created by 柿沼儀揚 on 2020/07/10.
//  Copyright © 2020 柿沼儀揚. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

class ViewController: UIViewController{
    
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
    }
    
    @IBAction func toppedRegisterButton(_ sender: Any) {
        
        createAccount()
    }
    
    func createAccount(){
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        Auth.auth().createUser(withEmail: email, password: password) { (res, err) in
            if let err = err {
                print("認証情報の保存に失敗しました。\(err)")
                return
            }
            print("認証情報の保存に成功しました。")
            
            guard let uid = res?.user.uid else { return }
            
            let docData = [
                "email": email,
                "password": password,
                "createdAt": Timestamp(),
                ] as [String : Any]
            
            Firestore.firestore().collection("users").document(uid).setData(docData) { (err) in
                if let err = err {
                    print("Firestoreへの保存に失敗しました。\(err)")
                    return
                }
                print("Firestoreへの情報の保存が成功しました。")
            }
        }
    }
    
    
    @IBAction func toppedLoginButton(_ sender: Any) {
        authlogin()
    }
    
    
    func authlogin(){
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        Auth.auth().signIn(withEmail: email, password: password){ (res, err) in
            if let err = err {
                print("ログインに失敗しました\(err)")
                return
            }
            print("ログインに成功しました")
        }
    }
}
extension ViewController: UITextFieldDelegate {
    
}

