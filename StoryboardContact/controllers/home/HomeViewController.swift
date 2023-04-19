//
//  HomeViewController.swift
//  StoryboardContact
//
//  Created by Bekhruz Hakmirzaev on 15/04/23.
//

import UIKit

class HomeViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource, HomeView {
    
    
    @IBOutlet weak var tableView: UITableView!
    var items = Array<Contact>()
    var presenter: HomePresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initViews()
    }
    
    func onLoadContacts(contacts: [Contact]) {
        if contacts.count > 0 {
            refreshTableView(contacts: contacts)
        } else {
            // error case
        }
    }
    
    func onContactDelete(deleted: Bool) {
        if deleted {
            presenter.apiContactList()
        } else {
            // error case
        }
    }
    
    func refreshTableView(contacts: [Contact]) {
        self.items = contacts
        self.tableView.reloadData()
    }
    

    // MARK: - Method
    
    func initViews() {
        tableView.dataSource = self
        tableView.delegate = self
        
        initNavigation()
        
        presenter = HomePresenter()
        presenter.homeView = self
        presenter.controller = self
        
        presenter.apiContactList()
    }
    
    func initNavigation() {
        let refresh = UIImage(named: "ic_refresh")
        let add = UIImage(named: "ic_add")
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: refresh, style: .plain, target: self, action: #selector(leftTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: add, style: .plain, target: self, action: #selector(rightTapped))
        title = "Storyboard Contact"
    }
    
    func callCreateViewController() {
        let vc = CreateViewController(nibName: "CreateViewController", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func callEditViewController(contact: Contact) {
        let vc = EditViewController(nibName: "EditViewController", bundle: nil)
        vc.contact = contact
        let nc = UINavigationController(rootViewController: vc)
        self.present(nc, animated: true)
    }

    // MARK: - Action
    
    @objc func leftTapped() {
        presenter.apiContactList()
    }
    
    @objc func rightTapped() {
        callCreateViewController()
    }
    
    // MARK: - Table View
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        
        let cell = Bundle.main.loadNibNamed("ContactTableViewCell", owner: self, options: nil)?.first as! ContactTableViewCell
        
        cell.nameLabel.text = item.name
        cell.phoneLabel.text = item.phone
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?{
        return UISwipeActionsConfiguration(actions: [makeCompleteContextualAction(forRowAt: indexPath, contact: items[indexPath.row])])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return UISwipeActionsConfiguration(actions: [makeDeleteContextualAction(forRowAt: indexPath, contact: items[indexPath.row])])
    }
    
    // MARK: - Contextual Actions
    
    private func makeDeleteContextualAction(forRowAt indexPath: IndexPath, contact: Contact) -> UIContextualAction{
        return UIContextualAction(style: .destructive, title: "Delete") { (action, swipeButtonView, completion) in
            print("DELETE HERE")
            
            self.presenter.apiContactDelete(contact: contact)
            completion(true)
        }
    }
    
    private func makeCompleteContextualAction(forRowAt indexPath: IndexPath, contact: Contact) -> UIContextualAction{
        return UIContextualAction(style: .normal, title: "Edit") { (action, swipeButtonView, completion) in
            print("COMPLETE HERE")
            self.callEditViewController(contact: contact)
            completion(true)
        }
    }
}
