//
//  HomepagetestViewController.swift
//  Qwerty
//
//  Created by Jonathan Herbert on 09/04/21.
//

import UIKit

class HomepagetestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func settingButton(_ sender: UIButton) {
        performSegue(withIdentifier: "gotoSettingSegue", sender: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
