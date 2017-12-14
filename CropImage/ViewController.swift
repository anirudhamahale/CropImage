//
//  ViewController.swift
//  CropImage
//
//  Created by Anirudha on 14/12/17.
//  Copyright © 2017 Anirudha Mahale. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func ClickTapped(_ sender: UIButton) {
        self.performSegue(withIdentifier: "PushImageViewController", sender: nil)
    }
}

