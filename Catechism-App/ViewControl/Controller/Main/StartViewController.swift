//
//  StartViewController.swift
//  FeedBack-Team-D-1
//
//  Created by David Gonzalez on 2/28/22.
//

import UIKit
import Speech
import FacebookLogin

class StartViewController: UIViewController, LoginButtonDelegate {

    // MARK: GCD
    // GCD
    let firstD = DispatchQueue(label: "first queue", qos: .userInitiated)
    let secondD = DispatchQueue(label: "second queue", qos: .utility)
    var db: DBHelper = DBHelper()
    var isFacebookUser = "N"

    // MARK: IBOutlets
    @IBOutlet weak var showP: UIButton!
    @IBOutlet weak var hidePas: UIButton!
    @IBOutlet weak var userText: UITextField!
    @IBOutlet weak var error: UILabel!
    @IBOutlet weak var micro: UIButton!
    @IBOutlet weak var userPasswordText: UITextField!
    @IBOutlet weak var loginB: UIButton!
    @IBOutlet weak var signUpB: UIButton!

    @IBOutlet weak var saveB: UIButton!
    @IBOutlet weak var imageL: UIImageView!

    @IBOutlet weak var thanksI: UIImageView!
    @IBOutlet weak var textFeedback: UILabel!


    // MARK: Variables
    var loginChecked = false
    var signupChecked = true
    var showFeedback = false
    var email = ""
    var password = ""

    var isStart = false
    let audioEng = AVAudioEngine()
    let req = SFSpeechAudioBufferRecognitionRequest()
    let speechR = SFSpeechRecognizer()
    var rTask: SFSpeechRecognitionTask!

    @IBOutlet weak var label: UILabel!

    @IBOutlet weak var lgbtn: FBLoginButton!

    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        label?.isHidden = true
        saveB.isHidden = true
        thanksI.isHidden = true

        // Login Button made by Facebook
        let loginButton = FBLoginButton()
        // Optional: Place the button in the center of your view.
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "sky.jpeg")!)
        
        loginButton.permissions = ["public_profile", "email"]
        loginButton.center = view.center
        loginButton.delegate = self
        loginButton.layer.cornerRadius = 20
        loginButton.layer.cornerRadius = 20

        if !showFeedback {
            imageL.isHidden = true
            label.isHidden = true
            textFeedback.isHidden = true
            micro.isHidden = true
            saveB.isHidden = true
        }

        view.addSubview(loginButton)

        loginB.layer.cornerRadius = 20
        signUpB.layer.cornerRadius = 20
        saveB.layer.cornerRadius = 20
        userText.text = email
        userPasswordText.text = password
    }
  
    // MARK: IBActions
    @IBAction func showPass(_ sender: Any) {
        print("Change passs")
        userPasswordText.isSecureTextEntry = false
        hidePas.isHidden = false
        showP.isHidden = true
    }

    @IBAction func hidePass(_ sender: Any) {
        print("Hide Change passs")
        userPasswordText.isSecureTextEntry = true
        hidePas.isHidden = true
        showP.isHidden = false
    }

    @IBAction func signUpB(_ sender: Any) {
        goNextView(nameView: "signUp")
    }

    //Activate Microphone for feedback
    @IBAction func activeMicro(_ sender: Any) {
        label.isHidden = false
        saveB.isHidden = false

        isStart = !isStart

        if isStart {
            startSpeechRec()
            micro.setTitle("stop", for: .normal)
            label.text = ""

            micro.tintColor = .blue
        } else {
            cancellSpeechRec()
            micro.setTitle("start", for: .normal)
            micro.tintColor = .red
        }
    }

    @IBAction func loginButton(_ sender: Any) {
        var found = "N"
        if validateData() {

            let data = DBHelper.init().getUsers()
            for d in data {
                if found == "N" {
                    if (d.name == userText.text!) && (userText.text! != "") {
                        if (d.password == userPasswordText.text!) {
                            if (d.subscriptionType != 3) {
                                found = "S"
                                thanksI.isHidden = true
                                imageL.isHidden = false
                                label.isHidden = true
                                textFeedback.isHidden = false
                                micro.isHidden = false
                                saveB.isHidden = true
                                let displayVC: WelcomeViewController = UIStoryboard(name: "StartStoryboard", bundle: nil).instantiateViewController(withIdentifier: "WelcomeSB") as! WelcomeViewController
                                displayVC.userData = d
                                displayVC.userWelcome = userText.text!
                                displayVC.susWelcome = String(d.subscriptionType)
                                displayVC.idUserWelcome = d.id
                                displayVC.modalPresentationStyle = .fullScreen
                                self.present(displayVC, animated: true, completion: nil)
                            } else {
                                print("Bloked user")
                                error.text = "User Blocked, call admin"

                            }
                        }
                        else {
                            error.text = "Password not valid"
                        }
                    }
                    else {
                        error.text = "User not valid or blocked"
                        print("User not valid  id:***********************:", d.id, "user: ", d.name, "pass:", d.password, d.subscriptionType)

                    }
                }
            }
        }
    }

    @IBAction func saveFeedBack(_ sender: Any) {

        db.insertFeedback(feedback: label.text!)
        saveB.isHidden = true
        thanksI.isHidden = false
        label.isHidden = true
        micro.isHidden = true
        textFeedback.isHidden = true
        imageL.isHidden = true
        micro.setTitle("start", for: .normal)
        micro.tintColor = .red
    }

    // MARK: FUNCTIONS
    func goNextView(nameView: String) {
        if (nameView == "signUp") {

            let displayVC: SignUpViewController = UIStoryboard(name: "StartStoryboard", bundle: nil).instantiateViewController(withIdentifier: "signUpSB") as! SignUpViewController

            displayVC.userWelcome = userText.text!
            displayVC.modalPresentationStyle = .fullScreen
            self.showDetailViewController(displayVC, sender: self)
        } else {
            print("no")
        }
    }

    func validateData() -> Bool {
        if userText.text! == "" {
            error.text = "Enter the user"
            return false
        }
        if userPasswordText.text! == "" && isFacebookUser != "S" {
            error.text = "Enter the password"
            return false
        }
        return true
    }

    // MARK: Speech to Text
    func startSpeechRec() {
        let nd = audioEng.inputNode
        let recordF = nd.outputFormat(forBus: 0)
        nd.installTap(onBus: 0, bufferSize: 1024, format: recordF) {
            (buffer, _) in self.req.append(buffer)
        }
        audioEng.prepare()
        do {
            try audioEng.start()
        } catch let err {
            printContent(err)
        }
        rTask = speechR?.recognitionTask(with: req, resultHandler: {
            (resp, error) in

            guard resp != nil else {
                print(error.debugDescription)

                return
            }
            let msg = resp?.bestTranscription.formattedString
            self.label.text = msg!

            var str: String = ""
            for seg in resp!.bestTranscription.segments {
                let indexTo = msg!.index(msg!.startIndex, offsetBy: seg.substringRange.location)
                str = String(msg![indexTo...])
            }

            switch str {
            case "Signup":
                self.goNextView(nameView: "signUp")
            case "signup":
                self.goNextView(nameView: "signUp")
            case "Sign-up":
                self.goNextView(nameView: "signUp")
            case "Sign up":
                self.goNextView(nameView: "signUp")
            case "sign up":
                self.goNextView(nameView: "signUp")
            case "up":
                self.goNextView(nameView: "signUp")
            case "go":
                self.goNextView(nameView: "signUp")
            case "Go":
                self.goNextView(nameView: "signUp")
            case "Login":
                self.goNextView(nameView: "signUp")

            default:
                print("No existe")
            }
        })
        print("start")
    }

    func cancellSpeechRec() {
        rTask.finish()
        rTask.cancel()
        rTask = nil
        req.endAudio()
        audioEng.stop()

        if audioEng.inputNode.numberOfInputs > 0 {
            audioEng.inputNode.removeTap(onBus: 0)
        }
        print("cancel")
    }
    
    // MARK: FACEBOOK LOGIN
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        if result?.isCancelled ?? false {
            print("Cancelled")
        } else if error != nil {
            print("ERROR: Trying to get login results")
        } else {
            print("Logged in")
            self.getUserProfile(token: result?.token, userId: result?.token?.userID)
        }
    }

    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        // Do something after the user pressed the logout button
        print("You logged out!")
    }

    func loginButtonClicked() {
        let loginManager = LoginManager()
        loginManager.logIn(permissions: ["public_profile", "email"], from: self, handler: { result, error in
                if error != nil {
                    print("ERROR: Trying to get login results")
                } else if result?.isCancelled != nil {
                    print("The token is \(result?.token?.tokenString ?? "")")
                    if result?.token?.tokenString != nil {
                        print("Logged in")
                        self.getUserProfile(token: result?.token, userId: result?.token?.userID)
                    } else {
                        print("Cancelled")
                    }
                }
            })
    }

    @IBAction func facebookLoginBtnAction(_ sender: UIButton) {
        self.loginButtonClicked()
    }

    func getUserProfile(token: AccessToken?, userId: String?) {
        let graphRequest: GraphRequest = GraphRequest(graphPath: "me", parameters: ["fields": "id, first_name, middle_name, last_name, name, picture, email"])
        graphRequest.start { _, result, error in
            if error == nil {
                let data: [String: AnyObject] = result as! [String: AnyObject]

                // Facebook Id
                if let facebookId = data["id"] as? String {
                    print("Facebook Id: \(facebookId)")
                } else {
                    print("Facebook Id: Not exists")
                }

                // Facebook First Name
                if let facebookFirstName = data["first_name"] as? String {
                    self.userText.text = facebookFirstName
                    self.db.insertUsers(name: self.userText.text ?? "Davi", password: "", subscriptionType: 2)
                    self.isFacebookUser = "S"
                    print("Data Facebook stored:", self.userText.text ?? "")

                } else {
                    print("Facebook First Name: Not exists")
                }

                // Facebook Middle Name
                if let facebookMiddleName = data["middle_name"] as? String {
                    print("Facebook Middle Name: \(facebookMiddleName)")
                } else {
                    print("Facebook Middle Name: Not exists")
                }

                // Facebook Last Name
                if let facebookLastName = data["last_name"] as? String {
                    print("Facebook Last Name: \(facebookLastName)")
                } else {
                    print("Facebook Last Name: Not exists")
                }

                // Facebook Name
                if let facebookName = data["name"] as? String {
                    print("Facebook Name: \(facebookName)")
                } else {
                    print("Facebook Name: Not exists")
                }

                // Facebook Profile Pic URL
                let facebookProfilePicURL = "https://graph.facebook.com/\(userId ?? "")/picture?type=large"
                print("Facebook Profile Pic URL: \(facebookProfilePicURL)")

                // Facebook Email
                if let facebookEmail = data["email"] as? String {
                    print("Facebook Email: \(facebookEmail)")

                } else {
                    print("Facebook Email: Not exists")
                }

                print("Facebook Access Token: \(token?.tokenString ?? "")")
            } else {
                print("Error: Trying to get user's info")
            }
        }
    }

    func isLoggedIn() -> Bool {
        let accessToken = AccessToken.current
        let isLoggedIn = accessToken != nil && !(accessToken?.isExpired ?? false)
        return isLoggedIn
    }
}
