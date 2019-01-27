//
//  PhotoViewModel.swift
//  PhotoLab
//
//  Created by Elena Yanovskaya on 27/01/2019.
//  Copyright © 2019 Elena Yanovskaya. All rights reserved.
//

class Photo: Decodable {
    var url: String!
}

import Foundation

class PhotoViewModel {
    
    // MARK: - Constants
    
    private enum Constants {
        static let baseURL = "https://makub.ru"
    }
    
    // MARK: - Public Properties
    
    let photoURL: String!
    
    // MARK: - Initialization
    
    init(_ photo: Photo) {
        
        self.photoURL = (Constants.baseURL + photo.url).encodeInURL()
    }
}

extension String {
    
    func encodeInURL() -> String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!
    }
}
