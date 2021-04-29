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
    
    private var noteViewModel = NoteViewModel()
    
    let bag = DisposeBag()
                                                                                                 
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        noteViewModel.getAllNotes()
        getNotes()
    }

    private func getNotes() {
        noteViewModel.noteSubject.subscribe(onNext: { element in
            print("element \(element)")
            }, onDisposed: {
                print("Disposed")
        })
        .disposed(by: bag)
        
    }
    
    func getAllNotesCount() {
        print("Number of items \(noteViewModel.numberOfItems())")
    }

    private func updateNotes(note: [Note]) {
        print("UpdatedNotes \(note)")
    }
    
    func getAllNotes() {
        let notes = noteViewModel
        notes.getAllNotes()
    }
    
}

