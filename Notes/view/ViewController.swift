//
//  ViewController.swift
//  Notes
//
//  Created by Andrew Ananda on 07/04/2021.
//  Copyright © 2021 Andrew Ananda. All rights reserved.
//

import UIKit
import RxRelay
import RxSwift

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var noteViewModel = NoteViewModel()
    
    let bag = DisposeBag()
                                                                                                 
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //noteViewModel.deleteAllNotes()
        noteViewModel.getAllNotes()
        
        tableView.rx.setDelegate(self).disposed(by: bag)
        
        bindTableView()
    }
    
    private func bindTableView() {
        tableView.register(UINib(nibName: "NoteTableCellTableViewCell", bundle: nil), forCellReuseIdentifier: "cellId")
        
        noteViewModel.noteSubject.bind(to: tableView.rx.items(cellIdentifier: "cellId", cellType: NoteTableCellTableViewCell.self)){(row,item,cell) in
            cell.textLabel?.text = item.title
        }.disposed(by: bag)
        
        tableView.rx.modelSelected(Note.self).subscribe(onNext: { item in
            print("SelectedItem: \(item.title)")
                }).disposed(by: bag)
        noteViewModel.getAllNotes()
    }
    
    func getAllNotesCount() {
        print("Number of items \(noteViewModel.numberOfItems())")
    }

    func getAllNotes() {
        let notes = noteViewModel
        notes.getAllNotes()
    }
    
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 50
        }
}
