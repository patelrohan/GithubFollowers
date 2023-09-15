//
//  GHFError.swift
//  GithubFollowers
//
//  Created by Rohan on 9/15/23.
//

import Foundation

enum GHFError: String, Error {
    case invalidUsername            = "This username created invalid request. Please try again."
    case unableToCompleteRequest    = "Unable to complete your request. Please check your internet connection."
    case invalidServerResponse      = "Invalid response from the server. Please try again."
    case invalidData                = "Data received from the server was invalid. Please try again."
}
