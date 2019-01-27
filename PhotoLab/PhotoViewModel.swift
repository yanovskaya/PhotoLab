//
//  PhotoViewModel.swift
//  PhotoLab
//
//  Created by Elena Yanovskaya on 27/01/2019.
//  Copyright © 2019 Elena Yanovskaya. All rights reserved.
//


import Foundation

class PhotoViewModel {
    
    // MARK: - Constants
    
    private enum Constants {
        static let baseURL = "http://sinep.tech"
    }
    
    // MARK: - Public Properties
    
    let photoURL: String!
    
    // MARK: - Initialization
    
    init(_ photo: String) {
        
        self.photoURL = (Constants.baseURL + photo).encodeInURL()
    }
}

extension String {
    
    func encodeInURL() -> String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!
    }
}
