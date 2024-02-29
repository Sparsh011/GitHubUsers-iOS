//
//  ResponseDelegate.swift
//  GHFollowersSA
//
//  Created by Sparsh on 22/02/24.
//

import Foundation

protocol ResponseDelegate: AnyObject {
    func didFetchData<T>(_ response: T)
    func didFailFetchingData(_ error: Error)
}

