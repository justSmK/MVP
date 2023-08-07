//
//  AssemblyModuleBuilder.swift
//  MVP
//
//  Created by Sergei Semko on 8/4/23.
//

import UIKit.UIViewController

// DI

protocol AssemblyBuilderProtocol {
    func createMainModule() -> UIViewController
}

class AssemblyModuleBuilder: AssemblyBuilderProtocol {
    func createMainModule() -> UIViewController {
        let model = Person(firstName: "David", lastName: "Smith")
        let view = GreetingViewController()
        let presenter = GreetingPresenter(view: view, person: model)
        view.presenter = presenter
        return view
    }
}
