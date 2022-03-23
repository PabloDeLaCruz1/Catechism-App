//
//  DashboardViewController.swift
//  Catechism-App
//
//  Created by David Gonzalez on 3/15/22.
//  Dram TEam

import UIKit
import UserNotifications
import EventKit

class DashboardViewController: UIViewController {
    
    
    @IBOutlet weak var scoreFirst: UILabel!
    @IBOutlet weak var scoreSecond: UILabel!
    @IBOutlet weak var scordThird: UILabel!
    @IBOutlet weak var nameFirst: UILabel!
    @IBOutlet weak var nameSecond: UILabel!
    @IBOutlet weak var nameThird: UILabel!
    

    
    
    
    
    
    
    @IBOutlet weak var technology: UILabel!
    
  
    
    @IBOutlet weak var susO: UIButton!
    @IBAction func susB(_ sender: Any) {
        
        sendNotification()
        getAuth()
        susO .isEnabled = false
    }
    @IBAction func goLogin(_ sender: Any) {
        goNextView(nameView: "login")
    }
    let quizSessions = DBHelper.init().getQuizSessionsScore()
    var imageV1 : UIView!
    var imageV2 : UIView!
    var imageV3 : UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UNUserNotificationCenter.current().delegate = self
        technology.text = "I O S"
        //  graph()
        rankT1(t: "IOS")
        getScoreData()
        
    }
    
    var ScoreArray :  [String] = ["95","80","70","80","78","68","100","80","70"]
    // MARK: CALENDAR
    
    
    // MARK: FUNCTIONS
    func goNextView(nameView: String) {
        if (nameView == "login") {
            
            let displayVC: StartViewController = UIStoryboard(name: "StartStoryboard", bundle: nil).instantiateViewController(withIdentifier: "loginView") as! StartViewController
            
            displayVC.showFeedback = true
    
            self.present(displayVC, animated: true, completion: nil)
        } else {
            print("no")
        }
    }
    
    
    
    
    
    
    
    func getAuth(){
        let eStore = EKEventStore()
        switch EKEventStore.authorizationStatus(for: .event){
        case .authorized :
            addEvent(est: eStore)
            print("accses  ")
        case .denied:
            print("accses denied")
        case .notDetermined :
            eStore.requestAccess(to: .event, completion: {granted, err in
                if granted {
                    self.addEvent(est: eStore)
                }
                else{
                    print("no acces granted")
                }
            })
        default:
            print("")
        }
    }
    
    func addEvent(est : EKEventStore){
        let cl = est.calendars(for: .event)
        for c in cl{
            if c.title == "Calendar"{
                let sdt = Date()
                let edt = sdt.addingTimeInterval(200)
                let event = EKEvent(eventStore: est)
                event.calendar = c
                let intr : TimeInterval = -2 * 60
                let alrm = EKAlarm(relativeOffset: intr)
                event.alarms = [ alrm ]
                event.title = "Initial Catechism, Suscription Free"
                event.startDate = sdt
                event.endDate = edt
                do {
                    try est.save(event, span: .thisEvent)
                }
                catch{
                }
            }
        }
    }
    
    
    
    // MARK: NOTIFICATION USER
    
    
    func sendNotification(){
        print("Notification ini")
        UNUserNotificationCenter.current().getNotificationSettings{ notifs in
            
            switch notifs.authorizationStatus{
            case .notDetermined :
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]){
                    granted , err in
                    if let error = err {
                        print("request faile", error)
                    }
                    self.generateNotification()
                }
                
            case .authorized:
                
                self.generateNotification()
            case .denied :
                print("app not allowed")
            default :
                print("")
            }
            
        }
    }
    
    func generateNotification(){
        let ncont = UNMutableNotificationContent()
        print("generateNotification ini")
        ncont.title = "Congratulation"
        ncont.subtitle = "from Catechism"
        ncont.body = "You win a Free Suscription for 3 months, we will add the starting date to your calendar"
       // ncont.sound = UNNotificationSound.default
        
        let ntrigger = UNTimeIntervalNotificationTrigger(timeInterval: 7.0, repeats: false)
        let nreq = UNNotificationRequest(identifier: "User_Local_notification", content: ncont, trigger: ntrigger)
        
        UNUserNotificationCenter.current().add(nreq) { err in
            if let error = err {
                print("can add notification request", error )
            }
        }
        
    }
    
    
    
    
    
    
    //MARK: GRAPH
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
    // Queue GCD  QoS
    func getScoreData(){
        // ***
        for d in quizSessions {
            print("DispatchQueue.main.async:", d.id, "userId: ", d.userId, "score:", d.score, "Technology",d.subjectName)
        }
    }
  
    @IBAction func t1B(_ sender: Any) {
        rankT1(t : "IOS")
    }
    
    @IBAction func t2B(_ sender: Any) {
        rankT2(t : "MATH")
    }
    
    
    @IBAction func t3B(_ sender: Any) {
        rankT3(t : "DATA BASE")
    }
    // ***********************************************
    func rankT1( t : String){
        //DBHELPER
        var cont = 1
        for d in quizSessions {
            print("iniciaaaaaaaaaaaaaaaaaaaaaa/")
            switch cont{
              
            case 1:
                technology.text = t //d.subjectName
                scoreFirst.text = ScoreArray[0]
                let getUserById1  = DBHelper.init().getUserById(id: d.userId)
                nameFirst.text = "David"
                for n in getUserById1 {
                    print("Entrooooooo00000000000000000000000000o")
                    nameFirst.text =   n.name // "Pablo"//d.name
                }
              
                cont = cont + 1
            case 2:
                nameSecond.text = "Pablo"
                scoreSecond.text =  ScoreArray[1]
                let getUserById2  = DBHelper.init().getUserById(id: d.userId)
                for n in getUserById2 {
                    nameSecond.text =   n.name // "Pablo"//d.name
                }
        
                cont = cont + 1
            case 3:
                scordThird.text = ScoreArray[2]
                nameThird.text = "Young"
                let getUserById3  = DBHelper.init().getUserById(id: d.userId)
                for n in getUserById3 {
                    nameThird.text =   n.name // "Pablo"//d.name
                }
                cont = cont + 1
            default :
                print("f")
            }
            
        }
    }
    
    func rankT2( t : String){
        //DBHELPER
        var cont = 1
        for d in quizSessions {
            print("iniciaaaaaaaaaaaaaaaaaaaaaa/")
            switch cont{
              
            case 1:
                technology.text = t //d.subjectName
                scoreFirst.text =  ScoreArray[3]
                let getUserById1  = DBHelper.init().getUserById(id: d.userId)
                nameFirst.text = "Luis"
                for n in getUserById1 {
                    print("Entrooooooo00000000000000000000000000o")
                    nameFirst.text =   n.name // "Pablo"//d.name
                }
              
                cont = cont + 1
            case 2:
                nameSecond.text = "Daniel"
                scoreSecond.text =  ScoreArray[4]
                let getUserById2  = DBHelper.init().getUserById(id: d.userId)
                for n in getUserById2 {
                    nameSecond.text =   n.name // "Pablo"//d.name
                }
        
                cont = cont + 1
            case 3:
                scordThird.text =  ScoreArray[5]
                nameThird.text = "Melany"
                let getUserById3  = DBHelper.init().getUserById(id: d.userId)
                for n in getUserById3 {
                    nameThird.text =   n.name // "Pablo"//d.name
                }
                cont = cont + 1
            default :
                print("f")
            }
            
        }
    }
    
    func rankT3( t : String){
        //DBHELPER
        var cont = 1
        for d in quizSessions {
            switch cont{
              
            case 1:
                technology.text = t //d.subjectName
                scoreFirst.text =  ScoreArray[6]
                let getUserById1  = DBHelper.init().getUserById(id: d.userId)
                nameFirst.text = "Richard"
                for n in getUserById1 {
                    nameFirst.text =   n.name // "Pablo"//d.name
                }
              
                cont = cont + 1
            case 2:
                nameSecond.text = "Analy"
                scoreSecond.text =  ScoreArray[7]
                let getUserById2  = DBHelper.init().getUserById(id: d.userId)
                for n in getUserById2 {
                    nameSecond.text =   n.name // "Pablo"//d.name
                }
        
                cont = cont + 1
            case 3:
                scordThird.text =  ScoreArray[8]
                nameThird.text = "Boris"
                let getUserById3  = DBHelper.init().getUserById(id: d.userId)
                for n in getUserById3 {
                    nameThird.text =   n.name // "Pablo"//d.name
                }
                cont = cont + 1
            default :
                print("f")
            }
            
        }
    }
    
    
    
}

extension DashboardViewController : UNUserNotificationCenterDelegate{
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {  print("userNotificationCenter ini")
        completionHandler([.alert])
    }
}


