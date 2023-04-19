//
//  EditViewController.swift
//  StoryboardContact
//
//  Created by Bekhruz Hakmirzaev on 15/04/23.
//

import UIKit

class EditViewController: BaseViewController, EditView {

    var contact: Contact = Contact(name: "", phone: "")
    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var phoneLabel: UITextField!
    var presenter: EditPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
    }
    
    func initView() {
        nameLabel.text = contact.name!
        phoneLabel.text = contact.phone!
        
        title = "Edit Contact"
        
        presenter = EditPresenter()
        presenter.editView = self
        presenter.controller = self
    }
    
    func onEditContact(edited: Bool) {
        if edited {
            dismiss(animated: true, completion: nil)
        } else {
            // Error
            print("Error")
        }
    }

    @IBAction func saveButton(_ sender: Any) {
        if nameLabel.text != nil && phoneLabel.text != nil {
            self.presenter.apiContactEdit(contact: Contact(id: contact.id!, name: nameLabel.text!, phone: phoneLabel.text!))
        }
    }
    

}
