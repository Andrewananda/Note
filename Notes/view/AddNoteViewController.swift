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
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    private let viewModel = NoteViewModel()
    fileprivate let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loader.isHidden = true
        descriptionLabel.delegate = self
        descriptionLabel.text = "Add Notes"
    }

    @IBAction func saveNote(_ sender: UIButton) {
        validateInputs(title: titleLabel.text!, description: descriptionLabel.text)
    }
    
    private func displayLoader(show: Bool) {
        if show {
            loader.startAnimating()
            loader.isHidden = false
        }else {
            loader.stopAnimating()
            loader.hidesWhenStopped = true
        }
    }
    
    func validateInputs(title: String, description: String) {
        if title.isEmpty {
            print("Title is required")
        } else if description.isEmpty {
            print("Description is required")
        } else {
            viewModel.isCompleted.subscribe(onNext: {[weak self] res in
                self?.displayLoader(show: res)
            }).disposed(by: bag)
            
            viewModel.addNote(title: title, description: description)
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        self.descriptionLabel.text = nil
    }
}
