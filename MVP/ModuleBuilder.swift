//
//  ModuleBuilder.swift
//  MVP
//
//  Created by Sergei Semko on 8/4/23.
//

import UIKit.UIViewController

// DI

protocol Builder {
    static func createMainModule() -> UIViewController
}

class ModuleBuilder: Builder {
    static func createMainModule() -> UIViewController {
        let model = Person(firstName: "David", lastName: "Blaine")
        let view = MainViewController()
        let presenter = MainPresenter(view: view, person: model)
        view.presenter = presenter
        return view
    }
}
