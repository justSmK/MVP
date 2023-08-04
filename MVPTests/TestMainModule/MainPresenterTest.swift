//
//  MainPresenterTest.swift
//  MVPTests
//
//  Created by Sergei Semko on 8/4/23.
//

import XCTest
@testable import MVP

fileprivate class MockRouter: RouterProtocol {
    func initialViewController() {}
    func showDetail(comment: MVP.Comment?) {}
    func popToRoot() {}
    var navigationController: UINavigationController?
    var assemblyBuilder: MVP.AssemblyBuilderProtocol?
}

fileprivate class MockView: MainViewProtocol {
    var isSuccess: Bool = false
    var failureError: Error?
    
    func success() {
        isSuccess = true
    }
    
    func failure(error: Error) {
        failureError = error
    }
}

fileprivate class MockNetworkService: NetworkServiceProtocol {
    public var comments: [Comment]!

    init() {}

    convenience init(comments: [Comment]?) {
        self.init()
        self.comments = comments
    }
    
    func getComments(completion: @escaping (Result<[MVP.Comment]?, Error>) -> Void) {
        if let comments {
            completion(.success(comments))
        } else {
            let error = NSError(domain: "Failure Get Comments", code: 0, userInfo: nil)
            completion(.failure(error))
        }
    }
}

final class MainPresenterTest: XCTestCase {
    
    fileprivate var view: MockView!
    var presenter: MainPresenter!
    var networkService: NetworkServiceProtocol!
    var router: RouterProtocol!
    var comments = [Comment]()
    
    override func setUpWithError() throws {
        router = MockRouter()
        view = MockView()
    }

    override func tearDownWithError() throws {
        view = nil
        presenter = nil
        networkService = nil
        router = nil
    }
    
    func testGetSuccessComments() {
        let comment = Comment(postId: 1, id: 2, name: "Foo", email: "Baz", body: "Bar")
        comments.append(comment)
        
        networkService = MockNetworkService(comments: comments)
        presenter = MainPresenter(view: view, networkService: networkService, router: router)
        
        let expectation = self.expectation(description: "Fetching Comments")
        
        presenter.getComments()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5)
        
        XCTAssertTrue(view.isSuccess)
        XCTAssertNil(view.failureError)
        XCTAssertNotNil(presenter.comments)
        XCTAssertEqual(presenter.comments?.first, comment)
    }

    func testGetFailureComments() {

        networkService = MockNetworkService(comments: nil)
        presenter = MainPresenter(view: view, networkService: networkService, router: router)
        
        let expectation = self.expectation(description: "Fetching Comments")
        
        presenter.getComments()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5)
        
        XCTAssertFalse(view.isSuccess)
        XCTAssertNotNil(view.failureError)
        XCTAssertNil(presenter.comments)
    }
}
