//
//  ServiceLayer.swift
//  Makub
//
//  Created by Елена Яновская on 03.04.2018.
//  Copyright © 2018 Elena Yanovskaya. All rights reserved.
//

import Alamofire
import Foundation

final class ServiceLayer {
    
    static let shared = ServiceLayer()
    
    let photoService: PhotoService
    
    let requestSessionManager: SessionManager
    let uploadSessionManager: SessionManager
    
    private init() {
        requestSessionManager = {
            let configuration = URLSessionConfiguration.default
            configuration.timeoutIntervalForRequest = 20
            return SessionManager(configuration: configuration)
        }()
        uploadSessionManager = {
            let configuration = URLSessionConfiguration.default
            configuration.timeoutIntervalForRequest = 30
            return SessionManager(configuration: configuration)
        }()
        
        photoService = PhotoServiceImpl(requestSessionManager: requestSessionManager,
                                      uploadSessionManager: uploadSessionManager)
    }
    
}
