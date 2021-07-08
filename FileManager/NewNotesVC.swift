//
//  NewNotesVC.swift
//  Tap it!
//
//  Created by DCS on 02/07/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class NewNotesVC: UIViewController {


    var updateFile = ""

    private let myTextField:UITextField = {
        let textField = UITextField()
        textField.placeholder = "File Name"
        textField.textAlignment = .center
        textField.borderStyle = .roundedRect
        textField.autocapitalizationType = .none
         textField.textColor = .black
        textField.borderStyle = .roundedRect
        textField.layer.cornerRadius = 25
        return textField
    }()

    private let myTextView:UITextView = {
        let textView = UITextView()
        //textView.backgroundColor = .gray
        textView.textColor = .black
        textView.layer.cornerRadius = 25
        return textView
    }()

    private let myButton:UIButton = {
        let button = UIButton()
        button.setTitle("Save", for: .normal)
        button.addTarget(self, action: #selector(saveNote), for: .touchUpInside)
        button.backgroundColor = .gray
        button.layer.cornerRadius = 25
        return button
    }()

    @objc private func saveNote(){

        let name  = myTextField.text!
        let content = myTextView.text

        // check if text feild is empty

        if myTextField.text == "" {

            // Alert
            let optionMenu = UIAlertController(title: nil, message: "Please Enter File Name", preferredStyle: .alert)

            // Add actions to the menu
            let cancelAction = UIAlertAction(title: "Ok", style: .cancel, handler:
                nil)
            optionMenu.addAction(cancelAction)

            // Display the menu
            self.present(optionMenu, animated: true, completion: nil)

        } else {

            //uset to save name and content
            let filePath = DataService.getDocDir().appendingPathComponent("\(name).txt")

            do{
                try content?.write(to: filePath, atomically: true, encoding: .utf8)

                let fetchedContent = try String(contentsOf: filePath)
                print(fetchedContent)


                myTextField.text = ""
                myTextView.text = ""

                let alert = UIAlertController(title: "Success", message: "File Saved Successfully", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Dissmiss", style: .cancel, handler: { [weak self] _ in
                    self?.navigationController?.popViewController(animated: true)
                }))

                DispatchQueue.main.async {
                    self.present(alert, animated: true, completion:  nil)
                }
            } catch {
                print(error)
            }

        }





    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add Note!"
      // self.view.backgroundColor = .white
      
        view.addSubview(myTextField)
        view.addSubview(myTextView)
        view.addSubview(myButton)
        
        
     

        if updateFile != ""{

            myTextField.text = updateFile.components(separatedBy: ".").first
            myTextField.isEnabled = false

            let filePath = DataService.getDocDir().appendingPathComponent(updateFile)

            do{
                let content = try String(contentsOf: filePath)

                myTextView.text = content

            } catch{
                print(error)
            }
            print("in update")
        }
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "5.jpg")
        backgroundImage.contentMode =  UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        myTextField.frame = CGRect(x: 40, y: view.safeAreaInsets.top + 20, width: view.width - 80, height: 40)
        myTextView.frame = CGRect(x: 40, y: myTextField.bottom + 20, width: view.width - 80, height: 300)
        myButton.frame = CGRect(x: 40, y: myTextView.bottom + 20, width: view.width - 80, height: 40)
    }



}
