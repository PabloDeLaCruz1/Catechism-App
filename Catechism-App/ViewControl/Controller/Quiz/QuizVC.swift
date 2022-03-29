//
//  QuizVC.swift
//  QuizGame
//
//  Created by Abdinasir Hussein on 25/02/2018.
//  Copyright © 2018 Abdinasir Hussein. All rights reserved.
//
//Adapted by Ju on 3/12/2022 for non commercial purpose.
// All rights of the creator respected.

import UIKit
import SQLite3

struct QuestionFetched {
    let question: String
    let correctAnswer: Int
    var wrongAnswer: Int
    var isAnswered: Bool
    let choices: [String]
}

class QuizVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var questions = Array<QuestionSet>()
    var answersCV: UICollectionView!
    var questionsArray = [QuestionFetched]()
    var score: Int = 0
    var currentQuestionNumber = 1
    var typeChosen = ""
    
    var window: UIWindow?
    
    override func loadView() {
        super.loadView()

        self.title="QuizOne"
        self.view.backgroundColor=UIColor.white
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: self.view.frame.width, height: self.view.frame.height)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        
        questions = DBHelper.init().get5Quizes(type: typeChosen)  //TODO To accept the parameter value from users.

        answersCV=UICollectionView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height), collectionViewLayout: layout)
        answersCV.delegate=self
        answersCV.dataSource=self
        answersCV.register(QuizCVCell.self, forCellWithReuseIdentifier: "Cell")
        answersCV.backgroundColor=UIColor.blue
        answersCV.isPagingEnabled = true
        
        
        self.view.addSubview(answersCV)
        
        for k in 0...4 {
            let qVar = QuestionFetched(question: questions[k].question, correctAnswer: questions[k].correctAnswer, wrongAnswer: -1, isAnswered: false, choices: [questions[k].firstAnswer, questions[k].secondAnswer, questions[k].thirdAnswer, questions[k].fourthAnswer])

            questionsArray.append(qVar)
        }
        setupViews()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return questionsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell=collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! QuizCVCell
        cell.question=questionsArray[indexPath.row]
        cell.delegate=self
        return cell
    }
    
    func setQuestionNumber() {
        let x = answersCV.contentOffset.x
        let w = answersCV.bounds.size.width
        let currentPage = Int(ceil(x/w))
        if currentPage < questionsArray.count {
            lblQueNumber.text = "Question: \(currentPage+1) / \(questionsArray.count)"
            currentQuestionNumber = currentPage + 1
        }
    }
    
    // Go to Previous or Next Question View
    @objc func btnPrevNextAction(sender: UIButton) {
        if sender == btnNext && currentQuestionNumber == questionsArray.count {
            let nextVC=QuizSessionResult()
            nextVC.score = score
            nextVC.totalScore = questionsArray.count
            self.navigationController?.pushViewController(nextVC, animated: false)
            return
        }
        
        let collectionBounds = self.answersCV.bounds
        var contentOffset: CGFloat = 0
        if sender == btnNext {
            contentOffset = CGFloat(floor(self.answersCV.contentOffset.x + collectionBounds.size.width))
            currentQuestionNumber += currentQuestionNumber >= questionsArray.count ? 0 : 1
        } else {
            contentOffset = CGFloat(floor(self.answersCV.contentOffset.x - collectionBounds.size.width))
            currentQuestionNumber -= currentQuestionNumber <= 0 ? 0 : 1
        }
        self.moveToFrame(contentOffset: contentOffset)
        lblQueNumber.text = "Question: \(currentQuestionNumber) / \(questionsArray.count)"
    }
    
    func moveToFrame(contentOffset : CGFloat) {
        let frame: CGRect = CGRect(x : contentOffset ,y : self.answersCV.contentOffset.y ,width : self.answersCV.frame.width,height : self.answersCV.frame.height)
        self.answersCV.scrollRectToVisible(frame, animated: true)
    }
    
    func setupViews() {
        answersCV.topAnchor.constraint(equalTo: self.view.topAnchor).isActive=true
        answersCV.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive=true
        answersCV.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive=true
        answersCV.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive=true
        
        self.view.addSubview(btnPrev)
        btnPrev.heightAnchor.constraint(equalToConstant: 50).isActive=true
        btnPrev.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.5).isActive=true
        btnPrev.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive=true
        btnPrev.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive=true
        
        self.view.addSubview(btnNext)
        btnNext.heightAnchor.constraint(equalTo: btnPrev.heightAnchor).isActive=true
        btnNext.widthAnchor.constraint(equalTo: btnPrev.widthAnchor).isActive=true
        btnNext.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive=true
        btnNext.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive=true
        
        self.view.addSubview(lblQueNumber)
        lblQueNumber.heightAnchor.constraint(equalToConstant: 20).isActive=true
        lblQueNumber.widthAnchor.constraint(equalToConstant: 150).isActive=true
        lblQueNumber.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20).isActive=true
        lblQueNumber.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -80).isActive=true
        lblQueNumber.text = "Question: \(1) / \(questionsArray.count)"
        
        self.view.addSubview(lblScore)
        lblScore.heightAnchor.constraint(equalTo: lblQueNumber.heightAnchor).isActive=true
        lblScore.widthAnchor.constraint(equalTo: lblQueNumber.widthAnchor).isActive=true
        lblScore.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20).isActive=true
        lblScore.bottomAnchor.constraint(equalTo: lblQueNumber.bottomAnchor).isActive=true
        lblScore.text = "Score: \(score) / \(questionsArray.count)"
    }
    
    let btnPrev: UIButton = {
        let btn=UIButton()
        btn.setTitle("< Previous", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.backgroundColor=UIColor.orange
        btn.translatesAutoresizingMaskIntoConstraints=false
        btn.addTarget(self, action: #selector(btnPrevNextAction), for: .touchUpInside)
        return btn
    }()
    
    let btnNext: UIButton = {
        let btn=UIButton()
        btn.setTitle("Next >", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.backgroundColor=UIColor.purple
        btn.translatesAutoresizingMaskIntoConstraints=false
        btn.addTarget(self, action: #selector(btnPrevNextAction), for: .touchUpInside)
        return btn
    }()
    
    let lblQueNumber: UILabel = {
        let lbl=UILabel()
        lbl.text="0 / 0"
        lbl.textColor=UIColor.gray
        lbl.textAlignment = .left
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.translatesAutoresizingMaskIntoConstraints=false
        return lbl
    }()
    
    let lblScore: UILabel = {
        let lbl=UILabel()
        lbl.text="0 / 0"
        lbl.textColor=UIColor.gray
        lbl.textAlignment = .right
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.translatesAutoresizingMaskIntoConstraints=false
        return lbl
    }()
}

extension QuizVC: QuizCVCellDelegate {
    
    func didChooseAnswer(btnIndex: Int) {
        let centerIndex = getCenterIndex()
        guard let index = centerIndex else { return }
        questionsArray[index.item].isAnswered=true
        if questionsArray[index.item].correctAnswer != btnIndex {
            questionsArray[index.item].wrongAnswer = btnIndex
            score = 0
            DispatchQueue.global().async { AudioSounds.incorrect?.play() }
        } else {
            score += 1
            DispatchQueue.global().async { AudioSounds.correct?.play() }
        }
        lblScore.text = "Score: \(score) / \(questionsArray.count)"
        answersCV.reloadItems(at: [index])
    }
    
    func getCenterIndex() -> IndexPath? {
        let center = self.view.convert(self.answersCV.center, to: self.answersCV)
        let index = answersCV!.indexPathForItem(at: center)
        print(index ?? "index not found")
        return index
    }
}

//Sound Effects
private func pausePreviousSounds() {
    DispatchQueue.global().async {
        if let incorrectSound = AudioSounds.incorrect, incorrectSound.isPlaying {
            incorrectSound.pause()
            incorrectSound.currentTime = 0
        }
        
        if let correctSound = AudioSounds.correct, correctSound.isPlaying {
            correctSound.pause()
            correctSound.currentTime = 0
        }
    }
}


