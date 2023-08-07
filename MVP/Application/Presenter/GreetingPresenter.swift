//
//  GreetingPresenter.swift
//  MVP
//
//  Created by Sergei Semko on 8/4/23.
//

import Foundation

protocol GreetingView: AnyObject {
    func setGreeting(greeting: String)
}

protocol GreetingViewPresenter {
    init(view: GreetingView, person: Person)
    func showGreeting()
}

class GreetingPresenter : GreetingViewPresenter {
    weak var view: GreetingView?
    let person: Person
    
    required init(view: GreetingView, person: Person) {
        self.view = view
        self.person = person
    }
    
    func showGreeting() {
        let greeting = "Hello " + self.person.firstName + " " + self.person.lastName
        self.view?.setGreeting(greeting: greeting)
    }
}
