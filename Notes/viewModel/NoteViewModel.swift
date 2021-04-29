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
import RxRelay

class NoteViewModel {
    
    //observable sequence
    var noteSubject = BehaviorRelay<[Note]>(value: [])
        
    
    let realm  = try! Realm()
    var notesList: [Note] = []
    
        
    func addNote(title: String, description: String) {
        let note = Note()
        note.title = title
        note.desc = description
        
        try! realm.write{
            realm.add(note)
        }
    }
    
    func numberOfItems() -> Int {
        return notesList.count
    }
    
    
    func getAllNotes(){
        
        let notes = realm.objects(Note.self)
        for note in notes {
            notesList.append(note)
        }
        noteSubject.accept(notesList)

    }
    
    func deleteAllNotes() {
        realm.deleteAll()
    }
}
