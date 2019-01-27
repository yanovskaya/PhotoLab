//
//  NewsService.swift
//  Makub
//
//  Created by Елена Яновская on 03.04.2018.
//  Copyright © 2018 Elena Yanovskaya. All rights reserved.
//

import Foundation
import UIKit

protocol PhotoService: class {
    func addPhoto(title: String, image: UIImage, completion: ((ServiceCallResult<Photo>) -> Void)?)
}

enum ServiceCallResult<Payload> {
    case serviceSuccess(payload: Payload?)
    case serviceFailure(error: NSError)
}
