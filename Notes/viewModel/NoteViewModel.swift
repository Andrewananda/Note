//
//  NoteViewModel.swift
//  Notes
//
//  Created by Andrew Ananda on 09/04/2021.
//  Copyright © 2021 Andrew Ananda. All rights reserved.
//

import Foundation
import RealmSwift
import RxSwift

class NoteViewModel {
    
    //observable sequence
    private let noteSubject = PublishSubject<Note>()
    var noteObservable : Observable<Note>  {
        return noteSubject.asObservable()
    }
    
    func addNote(title: String, description: String) {
        let note = Note()
        note.title = title
        note.desc = description
        
        let realm  = try! Realm()
        try! realm.write{
            realm.add(note)
            noteSubject.onNext(note)
        }
    }
    
    func getAllNotes() {
        let realm = try! Realm()
        
        let notes = realm.objects(Note.self)
        print("Notes \(notes)")
    }
}
