//
//  Comment.swift
//  MVP
//
//  Created by Sergei Semko on 8/4/23.
//

import Foundation

struct Comment: Decodable {
    var postId: Int
    var id: Int
    var name: String
    var email: String
    var body: String
}
