//
//  ShowOneUserViewController.swift
//  Catechism-App
//
//  Created by Pablo De La Cruz on 3/22/22.
//

import UIKit
import MapKit
import Eureka

class ShowOneUserViewController: UIViewController  {


    var User = Users()

    @IBOutlet weak var scoreUIView: UIView!
    @IBOutlet weak var profileAvatar: UIImageView!
    @IBOutlet weak var mkMapView: MKMapView!

    let london = Capital(title: "London", coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), info: "Home to the 2012 Summer Olympics.")
    let oslo = Capital(title: "Oslo", coordinate: CLLocationCoordinate2D(latitude: 59.95, longitude: 10.75), info: "Founded over a thousand years ago.")
    let paris = Capital(title: "Paris", coordinate: CLLocationCoordinate2D(latitude: 48.8567, longitude: 2.3508), info: "Often called the City of Light.")
    let rome = Capital(title: "Rome", coordinate: CLLocationCoordinate2D(latitude: 41.9, longitude: 12.5), info: "Has a whole country inside it.")
    let washington = Capital(title: "Washington DC", coordinate: CLLocationCoordinate2D(latitude: 38.895111, longitude: -77.036667), info: "Named after George himself.")

    override func viewDidLoad() {
        super.viewDidLoad()

//        scoresTableView.delegate = self
//        scoresTableView.dataSource = self

        mkMapView.addAnnotations([london, oslo, paris, rome, washington])

        profileAvatar.layer.cornerRadius = profileAvatar.frame.size.width / 2
        profileAvatar.clipsToBounds = true
        // Do any additional setup after loading the view.
        print("----------------------------User Id:")
        print(User.id)
        
//
//        form +++ Section("Create Quiz")
//        <<< TextRow("Quiz Subject") { row in
//            row.title = "Quiz Subject"
//            row.placeholder = "iOS, Database, GCD"
//        }
//        for index in 1...1 {
//            form +++ Section("Question \(index)")
//            <<< TextAreaRow("Question #\(index)") { row in
//                row.title = "Question #\(index)"
//                row.placeholder = "Enter Your Question"
//                row.textAreaHeight = TextAreaHeight.dynamic(initialTextViewHeight: 30)
//            }
//            //Answers:
//            <<< TextAreaRow("Answer #\(index) - 1") { row in
//                row.title = "Answer #\(index) - 1"
//                row.placeholder = "Answer 1"
//                row.textAreaHeight = TextAreaHeight.dynamic(initialTextViewHeight: 30)
//
//            }
//
//        }


    }



    class Capital: NSObject, MKAnnotation {
        var title: String?
        var coordinate: CLLocationCoordinate2D
        var info: String

        init(title: String, coordinate: CLLocationCoordinate2D, info: String) {
            self.title = title
            self.coordinate = coordinate
            self.info = info
        }
    }


}
