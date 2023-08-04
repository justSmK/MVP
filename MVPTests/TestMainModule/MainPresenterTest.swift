//
//  MainPresenterTest.swift
//  MVPTests
//
//  Created by Sergei Semko on 8/4/23.
//

import XCTest
@testable import MVP

class MockView: MainViewProtocol {
    var titleTest: String?
    func setGreeting(greeting: String) {
        self.titleTest = greeting
    }
}

enum MainError: Error {
    case optionalError
}

final class MainPresenterTest: XCTestCase {
    
    var view: MockView?
    var person: Person?
    var presenter: MainPresenter?
    
    override func setUpWithError() throws {
        view = MockView()
        person = Person(firstName: "Baz", lastName: "Bar")
        guard let view, let person else {
            throw MainError.optionalError
        }
        presenter = MainPresenter(view: view, person: person)
    }

    override func tearDownWithError() throws {
        view = nil
        person = nil
        presenter = nil
    }
    
    func testModuleIsNotNil() {
        XCTAssertNotNil(view, "view is not nil")
        XCTAssertNotNil(person, "person is not nil")
        XCTAssertNotNil(presenter, "presenter is not nil")
    }
    
    func testView() {
        presenter?.showGreeting()
        XCTAssertEqual(view?.titleTest, "Baz Bar")
    }

    func testPersonModel() {
        XCTAssertEqual(person?.firstName, "Baz")
        XCTAssertEqual(person?.lastName, "Bar")
    }
    
    func testExample() throws {

    }


}
