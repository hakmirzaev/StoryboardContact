//
//  HomePresenter.swift
//  StoryboardContact
//
//  Created by Bekhruz Hakmirzaev on 19/04/23.
//

import Foundation

protocol HomePresenterProtocol {
    func apiContactList()
    func apiContactDelete(contact: Contact)
}

class HomePresenter: HomePresenterProtocol {
    
    var homeView: HomeView!
    var controller: BaseViewController!
    
    func apiContactList() {
        controller?.showProgress()
        
        AFHttp.get(url: AFHttp.API_CONTACT_LIST, params: AFHttp.paramsEmpty(), handler: { response in
            self.controller?.hideProgress()
            switch response.result {
            case .success:
                let contacts = try! JSONDecoder().decode([Contact].self, from: response.data!)
                self.homeView.onLoadContacts(contacts: contacts)
            case let .failure(error):
                print(error)
                self.homeView.onLoadContacts(contacts: [Contact]())
            }
        })
    }
    
    func apiContactDelete(contact: Contact) {
        controller?.showProgress()
        
        AFHttp.del(url: AFHttp.API_CONTACT_DELETE + contact.id!, params: AFHttp.paramsEmpty(), handler: { response in
            self.controller?.hideProgress()
            switch response.result {
            case .success:
                print(response.result)
                self.homeView.onContactDelete(deleted: true)
            case let .failure(error):
                print(error)
                self.homeView.onContactDelete(deleted: false)
            }
        })
    }
    
}
