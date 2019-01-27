//
//  AddNewsPresentationModel.swift
//  Makub
//
//  Created by Елена Яновская on 17.04.2018.
//  Copyright © 2018 Elena Yanovskaya. All rights reserved.
//

import Foundation
import UIKit

final class AddPhotoPresentationModel: PresentationModel {
    
    // MARK: - Public Properties
    
    var photoViewModel: PhotoViewModel!
    
    // MARK: - Private Properties
    
    private let photoService = ServiceLayer.shared.photoService
    
    // MARK: - Public Methods
    
    func addPhoto(image: UIImage) {
        state = .loading
        photoService.addPhoto(title: "Elena Yanovskaya", image: image) { result in
            switch result {
            case .serviceSuccess:
                self.state = .rich
            case .serviceFailure(let error):
                self.state = .error(code: error.code)
            }
        }
    }
}
