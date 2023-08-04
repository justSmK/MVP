//
//  RouterTest.swift
//  MVPTests
//
//  Created by Sergei Semko on 8/4/23.
//

import XCTest
@testable import MVP

fileprivate class MockNavigationController: UINavigationController {
    var presentedVC: UIViewController?
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        self.presentedVC = viewController
        super.pushViewController(viewController, animated: true)
    }
}

final class RouterTest: XCTestCase {
    
    var router: RouterProtocol!
    fileprivate let navigationController = MockNavigationController()
    let assemblyBuilder = AssemblyModuleBuilder()

    override func setUpWithError() throws {
        router = Router(navigationController: navigationController, assemblyBuilder: assemblyBuilder)
    }

    override func tearDownWithError() throws {
        router = nil
    }

    func testRouter() {
        router.showDetail(comment: nil)
        let detailViewController = navigationController.presentedVC
        XCTAssertTrue(detailViewController is DetailViewController)
        XCTAssertFalse(detailViewController is MainViewController)
    }

}
