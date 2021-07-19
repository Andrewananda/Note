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
            notesList.append(note)
            getAllNotes()
        }
    }
    
    func numberOfItems() -> Int {
        return notesList.count
    }
    
    
    func getAllNotes(){
        
        let notes = realm.objects(Note.self)
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let data = try! encoder.encode(notes)
    
        do {
            let decoder = JSONDecoder()
            decoder.dataDecodingStrategy = .base64
            let notes = try decoder.decode([Note].self, from: data)
            setNotes(notes: notes)
        }catch(let error) {
            print("Unable to decode \(error)")
        }
    }
    
    private func setNotes(notes: [Note]) {
        noteSubject.accept(notes)
    }
    
    func deleteAllNotes() {
        try! realm.write {
            realm.deleteAll()
        }
    }
}
