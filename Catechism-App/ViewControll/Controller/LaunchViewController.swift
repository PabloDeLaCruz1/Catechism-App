//
//  LaunchViewController.swift
//  Catechism-App
//
//  Created by David Gonzalez on 3/16/22.
//

import UIKit

class LaunchViewController: UIViewController {

    
    
    @IBOutlet weak var image: UIImageView!
    
    func animateRotation(){
        UIView.animate(withDuration: 1.75, animations: {
            self.image.transform = CGAffineTransform(rotationAngle:  .pi)
        })
        UIView.animate(withDuration: 2.0, animations: {
            self.image.transform = CGAffineTransform(rotationAngle:  2 * .pi)
                    })
    }
    func endAnimation(){
        UIView.animate(withDuration: 1.75, animations: {
            self.image.transform = CGAffineTransform(rotationAngle:  .pi)
        })
        UIView.animate(withDuration: 2.0, animations: {
            self.image.transform = CGAffineTransform(rotationAngle:  2 * .pi)
            self.image.alpha = 0
                    })
    }
    
    
    func startAnimate(){
        print("function was called")
        var timerCount = 0
        let timer = Timer.scheduledTimer(withTimeInterval: 1.75, repeats: true) { timer in
            timerCount += 1
            
            print(timerCount)
            if(timerCount == 2){
                self.endAnimation()
                timer.invalidate()
                let navigateTime = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false){
                    navigateTime in self.navigateToController()
                }
            }
            var count = 3
            repeat{
                self.animateRotation()
                count -= 1
            } while(count > 0)
        }
        
        //Timer.scheduledTimer(timeInterval: 1.75, target: self, selector: #selector(updateImage), userInfo: nil, repeats: true) // target where it shoudl find selector self means current one
    }
    
    //var functionCall = 0
    @objc func updateImage(){//argument of #selector refers to instance method updateImage() that is not exposed to o-c; add @objc to expose instance method to o-c
        /*
        functionCall += 1
        print(functionCall)
        if(functionCall == 3){
            endAnimation()
            //repeats = false
        }*/
        var count = 3
        repeat{
            animateRotation()
            count -= 1
        } while(count > 0)
    }
    
    
  
    
    // ******************************     FUNC
    // MARK: FUNCTIOS
    
   
//    
    func navigateToController(){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "menuSB") as! MenuViewController
//        let nextViewController = MenuViewController()
//        self.present(nextViewController, animated:true, completion:nil)
//        nextViewController.modalTransitionStyle = .crossDissolve
//        self.showDetailViewController(nextViewController, sender: self)
        nextViewController.modalPresentationStyle = .fullScreen

        present(nextViewController, animated: true)

    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
            
        startAnimate()
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "sky.jpeg")!)
    }

}
