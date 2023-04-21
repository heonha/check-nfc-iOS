//
//  Destination.swift
//  checkNFC
//
//  Created by Heonjin Ha on 2023/04/21.
//

import SwiftUI

protocol Destination {
    associatedtype V: View
    var view: V { get }
}
