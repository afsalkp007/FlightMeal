//
//  Resource.swift
//  Fooddie
//
//  Created by Afsal Mohammed on 19/12/2023.
//

import Foundation

// A network resource, identified by url and parameters
struct Resource {
  let url: URL
  let path: String?
  let httpMethod: String
  let parameters: [String: String]
  let headers: [String: String]
  
  init(
    url: URL,
    path: String? = nil,
    httpMethod: String = "GET",
    parameters: [String: String] = [:],
    headers: [String: String] = [:]
  ) {
    self.url = url
    self.path = path
    self.httpMethod = httpMethod
    self.parameters = parameters
    self.headers = headers
  }
}
