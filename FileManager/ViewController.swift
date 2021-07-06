//
//  ViewController.swift
//  FileManager
//
//  Created by DCS on 04/07/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let token = UserDefaults.standard.string(forKey: "sesionToken")
    let name = UserDefaults.standard.string(forKey: "username")
    
    private let username_lbl : UILabel = {
        let welcome = UILabel()
        welcome.text = ""
        welcome.textColor = .white
        welcome.textAlignment = .center
        welcome.shadowColor = .darkGray
        welcome.font = UIFont(name: "Helveticaneue-Bold", size: 16.0)
        return welcome
    }()
    
    
    //    private let login_btn:UIButton = {
    //        let button = UIButton()
    //        button.setTitle("Login", for: .normal)
    //        button.addTarget(self, action: #selector(loginClick), for: .touchUpInside)
    //        button.backgroundColor = .gray
    //        button.layer.cornerRadius = 25
    //        button.setTitleColor(.white, for: .normal)
    //        return button
    //    }()

    private let myNote:UIButton = {
        let button = UIButton()
       // button.setTitle("logut", for: .normal)
        button.addTarget(self, action: #selector(note), for: .touchUpInside)
        button.setImage(UIImage(named: "note"),for: .normal)
        //button.backgroundColor = .gray
//        button.layer.cornerRadius = 25
//        button.setTitleColor(.white, for: .normal)
        return button
    }()

    private let logout_btn:UIButton = {
        let button = UIButton()
        button.setTitle("Logout", for: .normal)
        button.addTarget(self, action: #selector(logoutTapped), for: .touchUpInside)
        button.backgroundColor = .gray
        button.layer.cornerRadius = 25
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    @objc private func logoutTapped(){
        
        UserDefaults.standard.setValue(nil, forKey: "sesionToken")
        UserDefaults.standard.setValue(nil, forKey: "username")
        
        let lv = LoginVC()
        let nav = UINavigationController(rootViewController: lv)
        nav.modalPresentationStyle = .fullScreen
        nav.setNavigationBarHidden(true, animated: false)
        present(nav,animated: false)
        
    }
    
    
    @objc private func note(){

        let nt = NotesVC()
        navigationController?.pushViewController(nt, animated: true)
    }
    
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Notes 🖊"
        print("run")
        //view.addSubview(logo_img)
        view.addSubview(username_lbl)
        //        view.addSubview(login_btn)
        view.addSubview(myNote)
        view.addSubview(logout_btn)
        
        
                let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
                backgroundImage.image = UIImage(named: "3.jpg")
                backgroundImage.contentMode =  UIView.ContentMode.scaleAspectFill
                self.view.insertSubview(backgroundImage, at: 0)
        
        let alert = UIAlertController(title: "Login Successfully", message: "Please Tap On Notes To Add,Update and Delete Notes 😊", preferredStyle: UIAlertController.Style.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
//
//    @objc private func logoutTapped(){
//
//        UserDefaults.standard.setValue(nil, forKey: "sesionToken")
//        UserDefaults.standard.setValue(nil, forKey: "username")
//        print("session clear")
//
//        let lv = LoginVC()
//        let nav = UINavigationController(rootViewController: lv)
//        nav.modalPresentationStyle = .fullScreen
//        nav.setNavigationBarHidden(true, animated: false)
//        present(nav,animated: false)
//    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        checkUserAuth()
    }
    
    private func checkUserAuth(){
        
        if let token  = UserDefaults.standard.string(forKey: "sesionToken"),
            let name = UserDefaults.standard.string(forKey: "username"){
            print(" token :  \(token)")
            username_lbl.text = "Welcome, \(name)"
        } else {
            
            let lv = LoginVC()
            let nav = UINavigationController(rootViewController: lv)
            nav.modalPresentationStyle = .fullScreen
            nav.setNavigationBarHidden(true, animated: false)
            present(nav,animated: false)
        }
        
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        username_lbl.frame = CGRect(x: 20, y: 80, width: (view.width-40), height: 40)
        //        login_btn.frame = CGRect(x: 20, y: username_lbl.bottom + 20, width: (view.width-40), height: 40)
        myNote.frame = CGRect(x: 140, y: username_lbl.bottom + 200, width: 100, height: 100)
        logout_btn.frame = CGRect(x: 20, y: myNote.bottom + 20, width: (view.width-40), height: 40)
        
    }
    

}

