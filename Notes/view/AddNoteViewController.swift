//
//  AddNoteViewController.swift
//  Notes
//
//  Created by Andrew Ananda on 10/04/2021.
//  Copyright © 2021 Andrew Ananda. All rights reserved.
//

import UIKit
import RxCocoa

class AddNoteViewController: UIViewController {

    @IBOutlet weak var titleLabel: UITextField!
    @IBOutlet weak var descriptionLabel: UITextView!
    
    private let viewModel = NoteViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func saveNote(_ sender: UIButton) {
        if let title = titleLabel.text, let description = descriptionLabel.text {
            //observer sequence
            viewModel.addNote(title: title, description: description)
        }
    }
    
}
