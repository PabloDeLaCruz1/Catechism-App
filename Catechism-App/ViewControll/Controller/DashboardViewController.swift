//
//  DashboardViewController.swift
//  Catechism-App
//
//  Created by David Gonzalez on 3/15/22.
//

import UIKit

class DashboardViewController: UIViewController {
    
    
    @IBOutlet weak var scoreFirst: UILabel!
    @IBOutlet weak var scoreSecond: UILabel!
    @IBOutlet weak var scordThird: UILabel!
    @IBOutlet weak var nameFirst: UILabel!
    @IBOutlet weak var nameSecond: UILabel!
    @IBOutlet weak var nameThird: UILabel!
    
    @IBOutlet weak var technology: UILabel!
    
    
    var imageV1 : UIView!
    var imageV2 : UIView!
    var imageV3 : UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        technology.text = "I O S"
      //  graph()
        rank()
         
    }
    
    func graph(){
        //
        imageV1 = UIView()
        imageV1.backgroundColor = UIColor.blue
        imageV1.frame = CGRect(x: 80, y: 470, width: 50, height: 130)
        self.view.addSubview(imageV1)
        
        
        imageV2 = UIView()
        imageV2.backgroundColor = UIColor.blue
        imageV2.frame = CGRect(x: 185, y: 410, width: 50, height: 190)
        self.view.addSubview(imageV2)
        
        imageV3 = UIView()
        imageV3.backgroundColor = UIColor.blue
        imageV3.frame = CGRect(x: 290, y: 500, width: 50, height: 100)
        self.view.addSubview(imageV3)
        
    }
    // ************
    func rank(){
        //DBHELPER
        var cont = 1
        let data = DBHelper.init().getUsers() //  .inst.read()
        for d in data {
            switch cont{
            case 1:
                scoreFirst.text = "95"
                nameFirst.text = d.name
                cont = cont + 1
            case 2:
                scoreSecond.text = "80"
                nameSecond.text = d.name
                cont = cont + 1
            case 3:
                scordThird.text = "70"
                nameThird.text = d.name
                cont = cont + 1
            default :
                print("f")
            }
            
        }
    }
    
}



