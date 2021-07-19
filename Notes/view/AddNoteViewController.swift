//
//  AddNoteViewController.swift
//  Notes
//
//  Created by Andrew Ananda on 10/04/2021.
//  Copyright © 2021 Andrew Ananda. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class AddNoteViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var titleLabel: UITextField!
    @IBOutlet weak var descriptionLabel: UITextView!
    
    private let viewModel = NoteViewModel()
    fileprivate let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        descriptionLabel.delegate = self
        descriptionLabel.text = "Add Notes"
    }

    @IBAction func saveNote(_ sender: UIButton) {
        validateInputs(title: titleLabel.text!, description: descriptionLabel.text)
    }
    
    func validateInputs(title: String, description: String) {
        if title.isEmpty {
            print("Title is required")
        } else if description.isEmpty {
            print("Description is required")
        } else {
            viewModel.isCompleted.subscribe(onNext: {res in
                print("CompletedStatus \(res)")
            }).disposed(by: bag)
            
            viewModel.addNote(title: title, description: description)
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        self.descriptionLabel.text = nil
    }
}
