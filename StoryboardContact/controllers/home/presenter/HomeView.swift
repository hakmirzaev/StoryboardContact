//
//  HomeView.swift
//  StoryboardContact
//
//  Created by Bekhruz Hakmirzaev on 19/04/23.
//

import Foundation

protocol HomeView {
    func onLoadContacts(contacts: [Contact])
    func onContactDelete(deleted: Bool)
}
