//
//  CreatePresenter.swift
//  StoryboardContact
//
//  Created by Bekhruz Hakmirzaev on 19/04/23.
//

import Foundation

protocol CreatePresenterProtocol {
    func apiContactCreate(contact: Contact)
}

class CreatePresenter: CreatePresenterProtocol {
    
    var createView: CreateView!
    var controller: BaseViewController!
    
    func apiContactCreate(contact: Contact) {
        controller?.showProgress()
        AFHttp.post(url: AFHttp.API_CONTACT_CREATE, params: AFHttp.paramsContactCreate(contact: contact), handler: { response in
            self.controller?.hideProgress()
            switch response.result {
            case .success:
                print(response.result)
                self.createView.onCreateContact(created: true)
            case let .failure(error):
                print(error)
                self.createView.onCreateContact(created: false)
            }
        })
    }
    
}
