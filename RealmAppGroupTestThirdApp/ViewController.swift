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
    @IBOutlet weak var syncOtherButton: UIButton!
    @IBOutlet weak var writeOtherButton: UIButton!
    @IBOutlet weak var syncOtherRealmButton: UIButton!
    @IBOutlet weak var writeOtherRealmButton: UIButton!

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
    
    @IBAction func syncOtherButtonTapped(_ sender: Any) {
        syncOtherButton.isEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            SyncFetch.otherFetch {
                self.syncOtherButton.isEnabled = true
            }
        }
    }
    
    @IBAction func writeOtherButtonTapped(_ sender: Any) {
        writeOtherButton.isEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            OtherModel(id: UUID().uuidString, name: UUID().uuidString).save {
                self.writeOtherButton.isEnabled = true
            }
        }
        
    }
    
    @IBAction func syncOtherRealmButtonTapped(_ sender: Any) {
        syncOtherRealmButton.isEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            SyncFetch.otherRealmFetch {
                self.syncOtherRealmButton.isEnabled = true
            }
        }
    }
    
    @IBAction func writeOtherRealmButtonTapped(_ sender: Any) {
        writeOtherRealmButton.isEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            OtherModel(id: UUID().uuidString, name: UUID().uuidString).otherRealmSave {
                self.writeOtherRealmButton.isEnabled = true
            }
        }
        
    }
}
