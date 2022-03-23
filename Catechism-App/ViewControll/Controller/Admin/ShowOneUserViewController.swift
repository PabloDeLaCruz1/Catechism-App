//
//  ShowOneUserViewController.swift
//  Catechism-App
//
//  Created by Pablo De La Cruz on 3/22/22.
//

import UIKit
import MapKit
import Eureka

class ShowOneUserViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    var User = Users()

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var profileAvatar: UIImageView!
    @IBOutlet weak var mkMapView: MKMapView!

    @IBOutlet weak var userNameLabel: UILabel!
    struct Scores {
        var subjectsLabel  : String
        var scoresLabel: String
       
    }

    let london = Capital(title: "London", coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), info: "Home to the 2012 Summer Olympics.")
    let oslo = Capital(title: "Oslo", coordinate: CLLocationCoordinate2D(latitude: 59.95, longitude: 10.75), info: "Founded over a thousand years ago.")
    let paris = Capital(title: "Paris", coordinate: CLLocationCoordinate2D(latitude: 48.8567, longitude: 2.3508), info: "Often called the City of Light.")
    let rome = Capital(title: "Rome", coordinate: CLLocationCoordinate2D(latitude: 41.9, longitude: 12.5), info: "Has a whole country inside it.")
    let washington = Capital(title: "Washington DC", coordinate: CLLocationCoordinate2D(latitude: 38.895111, longitude: -77.036667), info: "Named after George himself.")

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 50
        

        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "sky.jpeg")!)
        tableView.delegate = self
        tableView.dataSource = self

        mkMapView.addAnnotations([london, oslo, paris, rome, washington])

        profileAvatar.layer.cornerRadius = profileAvatar.frame.size.width / 2
        profileAvatar.clipsToBounds = true
        // Do any additional setup after loading the view.
        print(User.id)
        userNameLabel.text = "\(User.name)'s Detail View!"

        self.view.addSubview(tableView)

    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Array(User.scoresBySubject).count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScoresBySubjectTableViewCell") as! ScoresBySubjectTableViewCell
//        Array(myDict)[index].key
        print(Array(User.scoresBySubject)[indexPath.row].key, Array(User.scoresBySubject)[indexPath.row].value, Array(User.scoresBySubject).count, "====================================")
//        cell.subjectLabel.text = "hello"
//        cell.scoreLabel.text = "score"
        
//        cell.subjectsLabel?.text = "hello"
        var subjectsKey = Array(User.scoresBySubject)[indexPath.row].key
        cell.subjectLabel.text = subjectsKey
        cell.scoreLabel.text = "\(User.scoresBySubject[subjectsKey]!)"

        return cell
    }
    
     func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerCell = tableView.dequeueReusableCell(withIdentifier: "HCell") as! HeaderCellForDetailTableViewCell
        headerCell.backgroundColor = UIColor.systemBlue

   

        return headerCell
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
