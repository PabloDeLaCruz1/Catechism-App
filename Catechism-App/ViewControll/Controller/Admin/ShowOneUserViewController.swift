//
//  ShowOneUserViewController.swift
//  Catechism-App
//
//  Created by Pablo De La Cruz on 3/22/22.
//

import UIKit

class ShowOneUserViewController: UIViewController {
    var User = Users()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("----------------------------User Id:")
        print(User.id)
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
