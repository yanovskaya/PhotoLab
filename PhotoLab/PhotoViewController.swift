//
//  PhotoViewController.swift
//  PhotoLab
//
//  Created by Elena Yanovskaya on 27/01/2019.
//  Copyright © 2019 Elena Yanovskaya. All rights reserved.
//

import UIKit
import Kingfisher

class PhotoViewController: UIViewController {

    var photoLink: String!
    @IBOutlet var newImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newImageView.kf.indicatorType = .activity
        newImageView.kf.setImage(with: URL(string: photoLink))
    }

    @IBAction func shateToFacebook(_ sender: Any) {
    }
    
}
