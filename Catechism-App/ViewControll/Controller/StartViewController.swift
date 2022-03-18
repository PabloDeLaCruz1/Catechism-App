//
//  StartViewController.swift
//  FeedBack-Team-D-1
//
//  Created by David Gonzalez on 2/28/22.
//

import UIKit
import Speech

class StartViewController: UIViewController {

    @IBOutlet weak var showP: UIButton!
    @IBOutlet weak var hidePas: UIButton!
    @IBOutlet weak var userText: UITextField!
    @IBOutlet weak var error: UILabel!
    @IBOutlet weak var micro: UIButton!
    @IBOutlet weak var userPasswordText: UITextField!
    @IBOutlet weak var loginB: UIButton!
    @IBOutlet weak var signUpB: UIButton!

    var loginChecked = false
    var signupChecked = true
    var email = ""
    var password = ""

    var isStart = false
    let audioEng = AVAudioEngine()
    let req = SFSpeechAudioBufferRecognitionRequest()
    let speechR = SFSpeechRecognizer()
    var rTask: SFSpeechRecognitionTask!

    @IBOutlet weak var label: UILabel!


    override func viewDidLoad() {
        super.viewDidLoad()
        //setupUI()
        loginB.layer.cornerRadius = 20
        signUpB.layer.cornerRadius = 20
        // Do any additional setup after loading the view.
        userText.text = email
        userPasswordText.text = password

    }

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

    // *********

    @IBAction func signUpB(_ sender: Any) {
        goNextView(nameView: "signUp")
    }

    func goNextView(nameView: String) {
        if (nameView == "signUp") {

            let displayVC: SignUpViewController = UIStoryboard(name: "StartStoryboard", bundle: nil).instantiateViewController(withIdentifier: "signUpSB") as! SignUpViewController

            displayVC.userWellcome = userText.text!

            self.present(displayVC, animated: true, completion: nil)
        } else {
            print("no")
        }
    }

//    @IBAction func loginButton(_ sender: Any) {
//        //DBHELPER
//        let data = DBHelper.init().getUsers() //  .inst.read()
//        for d in data {
//            @IBAction func activeMicro(_ sender: Any) {
//                isStart = !isStart
//                if isStart {
//                    startSpeechRec()
//                    micro.setTitle("stop", for: .normal)
//                    label.text = ""
//
//                    micro.tintColor = .blue
//
//                    //   sender.setTitle("stop", for: .normal)
//                } else {
//                    cancellSpeechRec()
//                    micro.setTitle("start", for: .normal)
//                    micro.tintColor = .red
//                    //  sender.setTitle("start", for: .normal)
//                }
//            }
//        }
//    }

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




    @IBAction func loginButton(_ sender: Any) {

        if validateData() {
            // ***
            //DBHELPER
            let data = DBHelper.init().getUsers() //  .inst.read()
            for d in data {

                if (d.name == userText.text!) && (userText.text! != "") {
                    if (d.password == userPasswordText.text!) {
                        let displayVC: WellcomeViewController = UIStoryboard(name: "StartStoryboard", bundle: nil).instantiateViewController(withIdentifier: "WellcomeSB") as! WellcomeViewController
                        displayVC.userWellcome = userText.text!
                        displayVC.susWellcome = String(d.subscriptionType)

                        self.present(displayVC, animated: true, completion: nil)
                        print("Exxiste  id:***********************:", d.id, "user: ", d.name, "pass:", d.password, d.subscriptionType)
                    } // ****
                        else {
                        error.text = "Password not valid"
                    }
                }
                else {
                    error.text = "User not valid"
                }
            }
        } // *******
    }

    func validateData() -> Bool {
        if userText.text! == "" {
            error.text = "Enter the user"
            return false
        }
        if userPasswordText.text! == "" {
            error.text = "Enter the password"
            return false
        }

        return true
    }

    // MARK: SPEECH
    func startSpeechRec() {
        let nd = audioEng.inputNode
        let recordF = nd.outputFormat(forBus: 0)
        nd.installTap(onBus: 0, bufferSize: 1024, format: recordF)
        {
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

            guard let rsp = resp else {
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

            //*** reconigzer
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
            default:
                print("No existe")
            }



        })


        print("start")
    }
}
