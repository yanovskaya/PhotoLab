//
//  PhotoServiceImpl.swift
//  Makub
//
//  Created by Елена Яновская on 03.04.2018.
//  Copyright © 2018 Elena Yanovskaya. All rights reserved.
//

import Alamofire
import Foundation

final class PhotoServiceImpl: PhotoService {
    
    // MARK: - Constants
    
    private enum Constants {
        static let baseURL = "http://sinep.tech"
        static let tokenParameter = "token"
        
        static let titleParameter = "name"
        static let textParameter = "text"
        static let imageParameter = "user_photo"
        
        static let idParameter = "id"
        
        static let jpgExtension = ".jpg"
    }
    
    private enum EndPoint {
        static let addPhoto = "/photo-hack/transform-photo"
    }
    
    // MARK: - Private Properties
    
    private let requestSessionManager: SessionManager
    private let uploadSessionManager: SessionManager
    private var transport: Transport!
    private let addPhotoParser = Parser<AddPhotoResponce>()
    
    // MARK: - Initialization
    
    init(requestSessionManager: SessionManager, uploadSessionManager: SessionManager) {
        self.requestSessionManager = requestSessionManager
        self.uploadSessionManager = uploadSessionManager
    }
    
    // MARK: - Public Methods
    
    
    func addPhoto(title: String, image: UIImage, completion: ((ServiceCallResult<AddPhotoResponce>) -> Void)?) {
        
        let parameters = [Constants.titleParameter: title, "link": "true"]
        let imageData = image.jpegData(compressionQuality: 1)
        
        let randomName = String(length: 5)
         transport = Transport(sessionManager: uploadSessionManager)
        transport.upload(method: .post,
                         url: Constants.baseURL + EndPoint.addPhoto,
                         parameters: parameters,
                         data: imageData!,
                         name: Constants.imageParameter,
                         fileName: randomName + Constants.jpgExtension) { transportResult in
                            
                            switch transportResult {
                            case .transportSuccess(let payload):
                                let resultBody = payload.resultBody
                                let parseResult = self.addPhotoParser.parse(from: resultBody)
                                switch parseResult {
                                case .parserSuccess(let model):
                                    
                                        completion?(ServiceCallResult.serviceSuccess(payload: model.link))
                                    
                                case .parserFailure(let error):
                                    
                                    completion?(ServiceCallResult.serviceFailure(error: error))
                                }
                            case .transportFailure(let error):
                                
                                completion?(ServiceCallResult.serviceFailure(error: error))
                            }
        }
    }
    
}

extension String {
    
    init(length: Int) {
        let letters: NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let len = UInt32(letters.length)
        var randomString = ""
        for _ in 0 ..< length {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }
        self.init(randomString)
    }
}
