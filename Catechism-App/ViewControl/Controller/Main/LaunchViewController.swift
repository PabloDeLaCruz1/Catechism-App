//
//  LaunchViewController.swift
//  Catechism-App
//
//  Created by David Gonzalez on 3/16/22.
//

import UIKit

// Application Entry Point
class LaunchViewController: UIViewController {

    @IBOutlet weak var image: UIImageView!

    func animateRotation() {
        UIView.animate(withDuration: 1.75, animations: {
            self.image.transform = CGAffineTransform(rotationAngle: .pi)
        })
        UIView.animate(withDuration: 2.0, animations: {
            self.image.transform = CGAffineTransform(rotationAngle: 2 * .pi)
        })
    }
    func endAnimation() {
        UIView.animate(withDuration: 1.75, animations: {
            self.image.transform = CGAffineTransform(rotationAngle: .pi)
        })
        UIView.animate(withDuration: 2.0, animations: {
            self.image.transform = CGAffineTransform(rotationAngle: 2 * .pi)
            self.image.alpha = 0
        })
    }

    func startAnimate() {
        var timerCount = 0
        let timer = Timer.scheduledTimer(withTimeInterval: 1.75, repeats: true) { timer in
            timerCount += 1

            if(timerCount == 2) {
                self.endAnimation()
                timer.invalidate()
                let navigateTime = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) {
                    navigateTime in self.navigateToController()
                }
            }
            var count = 3
            repeat {
                self.animateRotation()
                count -= 1
            } while(count > 0)
        }
    }

    @objc func updateImage() {

        var count = 3
        repeat {
            animateRotation()
            count -= 1
        } while(count > 0)
    }

    func navigateToController() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "menuSB") as! MenuViewController
        nextViewController.modalPresentationStyle = .fullScreen
        present(nextViewController, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        startAnimate()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "sky.jpeg")!)
    }
}
