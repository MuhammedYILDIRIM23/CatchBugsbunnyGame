//
//  ViewController.swift
//  CatchBugsbunnyGame
//
//  Created by Muhammed YILDIRIM  on 9.04.2021.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func exitbutton(_ sender: Any) {
        
        // Exit Check
        let alert = UIAlertController(title: "Closing the Game!", message: "Are You Sure You Want To Quit The Game?", preferredStyle: .alert)
        let alertButtonYes = UIAlertAction(title: "Yes", style: UIAlertAction.Style.cancel) { (UIAlertAction) in
            exit(0)
        }
        let alertButtonNo = UIAlertAction(title: "No", style: UIAlertAction.Style.default, handler: nil)
        
        alert.addAction(alertButtonYes)
        alert.addAction(alertButtonNo)
        self.present(alert, animated: true, completion: nil)
    }
    
}

