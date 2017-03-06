//
//  termsConditionsViewController.swift
//  styler
//
//  Created by vishnu Mindbees on 03/03/17.
//  Copyright © 2017 Quickblox. All rights reserved.
//

import UIKit

class termsConditionsViewController: UIViewController {
    let defaults = UserDefaults.standard
    @IBOutlet weak var terms: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        terms.isHidden=false;
        let returnValue: [NSString]? = UserDefaults.standard.object(forKey: "launchchecked") as? [NSString]
        print(returnValue)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
