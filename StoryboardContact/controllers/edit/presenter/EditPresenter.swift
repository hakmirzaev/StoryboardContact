//
//  EditPresenter.swift
//  StoryboardContact
//
//  Created by Bekhruz Hakmirzaev on 19/04/23.
//

import Foundation

protocol EditPresenterProtocol {
    func apiContactEdit(contact: Contact)
}

class EditPresenter: EditPresenterProtocol {
    
    var editView: EditView!
    var controller: BaseViewController!
    
    func apiContactEdit(contact: Contact) {
        controller?.showProgress()
        AFHttp.put(url: AFHttp.API_CONTACT_UPDATE + (contact.id)!, params: AFHttp.paramsContactUpdate(contact: contact), handler: { response in
            self.controller?.hideProgress()
            switch response.result {
            case .success:
                print(response.result)
                self.editView.onEditContact(edited: true)
            case let .failure(error):
                print(error)
                self.editView.onEditContact(edited: false)
            }
        })
    }
    
}
