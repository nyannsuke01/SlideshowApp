//
//  ShowPictureViewController.swift
//  SlideshowApp
//
//  Created by user on 2020/07/26.
//  Copyright © 2020 user. All rights reserved.
//

import UIKit

class ShowPictureViewController: UIViewController {

    var resultImage = UIImage()
    @IBOutlet weak var resultImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        resultImageView.image = resultImage

        // Do any additional setup after loading the view.
    }

    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
