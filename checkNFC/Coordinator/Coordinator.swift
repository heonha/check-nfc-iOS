//
//  Coordinator.swift
//  checkNFC
//
//  Created by Heonjin Ha on 2023/04/19.
//

import SwiftUI
import Combine

class Coordinator<V: Destination>: ObservableObject {

    var destination: V?
    var id = UUID().uuidString.prefix(4)

    @Published private var navigationTrigger: Bool = false

    init(destination: V) {
        self.destination = destination
        print("\(id) - Init Coordinator")
    }

    deinit {
        print("\(id) - deinit Coordinator")
    }

    func navigationLinkSection() -> some View {
        NavigationLink(isActive: Binding<Bool>(get: getTrigger, set: setTrigger(newValue:))) {
            destination?.view
        } label: {
            EmptyView()
        }
    }

    private func getTrigger() -> Bool {
        return navigationTrigger
    }

    private func setTrigger(newValue: Bool) {
        navigationTrigger = newValue
    }

    func push(destination: V) {
        self.destination = destination
        navigationTrigger.toggle()
    }

}
