//
//  ContactDelegate.swift
//  RotaryDialPhone
//
//  Created by Jose Carabez on 04/01/18.
//

import Foundation

protocol ContactDelegate {
    func onReceive(contactName: String?, contactPhoneNumber: String?)
}
