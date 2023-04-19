//
//  CreateViewController.swift
//  StoryboardContact
//
//  Created by Bekhruz Hakmirzaev on 15/04/23.
//

import UIKit

class CreateViewController: BaseViewController, CreateView {

    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var phoneLabel: UITextField!
    
    var presenter: CreatePresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
    }

    func initView() {
        title = "Create Contact"
        
        presenter = CreatePresenter()
        presenter.createView = self
        presenter.controller = self
    }
    
    func onCreateContact(created: Bool) {
        if created {
            self.navigationController?.popViewController(animated: true)
        } else {
            // Error
            print("Error")
        }
    }
    
    
    @IBAction func createButton(_ sender: Any) {
        if nameLabel.text != nil && phoneLabel.text != nil {
            self.presenter.apiContactCreate(contact: Contact(name: nameLabel.text!, phone: phoneLabel.text!))
        }
    }
    

}
