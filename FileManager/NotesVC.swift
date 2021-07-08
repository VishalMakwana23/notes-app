//
//  NotesVC.swift
//  Tap it!
//
//  Created by DCS on 02/07/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class NotesVC: UIViewController {

    private var notesArray = [String]()

    private let notesTableView = UITableView()


    var theurls = [URL]()


//    private func getDocDir() -> URL {
//
//        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
//        print("doc dir : \(paths[0])")
//        return paths[0]
//    }
    

    private func fetchNotes(){

        let path = DataService.getDocDir()
        do{
            let items = try FileManager.default.contentsOfDirectory(at: path, includingPropertiesForKeys: nil)

            notesArray.removeAll()

            for item in items{
                notesArray.append(item.lastPathComponent)
            }
        } catch {
            print(error)
        }
        notesTableView.reloadData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        fetchNotes()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
       // print(getDocDir())
        title = "Notes"
        self.view.backgroundColor = .white
        view.addSubview(notesTableView)
        setupTableView()

        let addItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(openNewNote))
        navigationItem.setRightBarButton((addItem), animated: true)




        // Get the document directory url
        let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!

        do {
            // Get the directory contents urls (including subfolders urls)
            let directoryContents = try FileManager.default.contentsOfDirectory(at: documentsUrl, includingPropertiesForKeys: nil, options: [])
            // print(directoryContents)
            theurls = directoryContents

        } catch {
            print(error.localizedDescription)
        }




    }

    @objc private func openNewNote(){

        let nn = NewNotesVC()
        navigationController?.pushViewController(nn, animated: true)

    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        notesTableView.frame = view.bounds
    }


}


extension NotesVC: UITableViewDataSource,UITableViewDelegate{

    private func setupTableView(){

        notesTableView.register(UITableViewCell.self, forCellReuseIdentifier: "notes")
        notesTableView.dataSource = self
        notesTableView.delegate = self
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notesArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "notes", for: indexPath)
        cell.textLabel?.text = notesArray[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let vc = NewNotesVC()
        vc.updateFile = notesArray[indexPath.row]

        navigationController?.pushViewController(vc, animated: true)
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            notesArray.remove(at: indexPath.row)
            notesTableView.beginUpdates()
            notesTableView.deleteRows(at: [indexPath], with: .middle)
            notesTableView.endUpdates()

//            let url = thedownloads[indexPath.row]
//            print(url)

            do {
                try FileManager.default.removeItem(at: theurls[indexPath.row])
            } catch {
                print(error)
            }


        }
    }


}
