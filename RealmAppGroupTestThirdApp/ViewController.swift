//
//  ViewController.swift
//  RealmAppGroupTestThirdApp
//
//  Created by Paul Uhn on 3/27/17.
//  Copyright © 2017 Paul Uhn. All rights reserved.
//

import UIKit
import RealmAppGroupTestFramework

class ViewController: UIViewController {

    @IBOutlet weak var fetchButton: UIButton!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var writeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func buttonTapped(_ sender: Any) {
        print("sync...")
        SyncClient.sync {
            print("sync done")
        }
    }

    @IBAction func fetchButtonTapped(_ sender: Any) {
        fetchButton.isEnabled = false
        textField.text = nil
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.fetchButton.isEnabled = true
            self.textField.text = SyncFetch.fetch()?.count.description
        }
    }
    
    @IBAction func writeButtonTapped(_ sender: Any) {
        writeButton.isEnabled = false
        SyncClient.add {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.writeButton.isEnabled = true
            }
        }
    }
}

