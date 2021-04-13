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
    private let notes = BehaviorRelay<[Note]>(value: [])
                                                                                                 
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getNotes()
        //getAllNotes()
        
        notes.subscribe(onNext: { [weak self] elements in
            self?.updateNotes(note: elements)
        }).disposed(by: bag)
    }

    private func getNotes() {
        let notesVm = noteViewModel
        notesVm.noteObservable.subscribe(onNext: { [weak self] element in
            self?.updateNotes(note: [element])
            print(element)
            }, onDisposed: {
                print("Disposed")
        })
        .disposed(by: bag)
    }

    private func updateNotes(note: [Note]) {
        print("UpdatedNotes \(note)")
    }
    
    func getAllNotes() {
        let notes = noteViewModel
        notes.getAllNotes()
    }
}

