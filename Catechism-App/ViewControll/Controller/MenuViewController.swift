//
//  MenuViewController.swift
//  Catechism-App
//
//  Created by David Gonzalez on 3/15/22.
//

import UIKit

class MenuViewController: UIViewController {

    @IBOutlet weak var startB: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
//        startB.layer.cornerRadius = 20
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "sky.jpeg")!)
    }
    
    @IBAction func startButtonPressed(_ sender: Any) {
          
            let storyBoard : UIStoryboard = UIStoryboard(name: "StartStoryboard", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "loginView") as! StartViewController

        nextViewController.modalPresentationStyle = .fullScreen
            present(nextViewController, animated: true)
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//        let backItem = UIBarButtonItem()
//           backItem.title = "Something Else"
//           navigationItem.backBarButtonItem = backItem // This wil
//    }
    

}
