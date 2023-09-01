//
//  ErrorMessage.swift
//  GithubFollowers
//
//  Created by Rohan on 9/1/23.
//

import Foundation

enum ErrorMessage: String {
    case invalidUsername            = "This username created invalid request. Please try again."
    case unableToCompleteRequest    = "Unable to complete your request. Please check your internet connection."
    case invalidServerResponse      = "Invalid response from the server. Please try again."
    case invalidData                = "Data received from the server was invalid. Please try again."
}