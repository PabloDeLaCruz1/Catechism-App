//
//  ViewUsersTableViewController.swift
//  Catechism-App
//
//  Created by Pablo De La Cruz on 3/17/22.
//

import UIKit
import FanMenu
import Macaw
import Eureka

class ViewUsersTableViewController: UITableViewController {
    let db = DBHelper.init()
    let Users = DBHelper.init().getUsers()
    let quizSessions = DBHelper.init().getQuizSessions()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "sky.jpeg")!)


    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return Users.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UserTableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! UserTableViewCell

        createFanMenu(cell: cell, userId: Users[indexPath.row].id, indexPath: indexPath)

        cell.userId.text = String(Users[indexPath.row].id)
        cell.userName.text = Users[indexPath.row].name
        cell.subType.text = String(Users[indexPath.row].subscriptionType)
        cell.totalScore.text = String(getTotalScoreById(id: Users[indexPath.row].id))
        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
//
//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//
//    }
//
    // Header Cell
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerCell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell") as! HeaderTableViewCell
        headerCell.backgroundColor = UIColor.systemBlue

        return headerCell
    }



    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }

    func getTotalScoreById(id: Int) -> Int {
        var score = 0
        for q in quizSessions {
            if q.userId == id {
                score += q.score
            }
        }
        return score;
    }
    func getUserTotalScoreBySubjectById(id: Int) -> [String : Int] {
        var score = 0
        var userScoreBySubject = [String: Int]()

        for q in quizSessions {
            if q.userId == id {
                score += q.score

                if userScoreBySubject[q.subjectName] == nil {
                    userScoreBySubject[q.subjectName] = q.score
                } else {
                    userScoreBySubject[q.subjectName]! += q.score
                }
            }
        }
        return userScoreBySubject;
    }

    func createFanMenu(cell: AnyObject, userId: Int, indexPath: IndexPath) {
        cell.fanMenu.button = FanMenuButton(
            id: "fanMenuButton",
            image: UIImage(systemName: "gearshape.fill"),
            color: Color(val: 0x7C93FE)
        )
        cell.fanMenu.items = [
            FanMenuButton(
                id: "block_user_id",
                image: UIImage(systemName: "person.fill.xmark"),
                color: Color(val: 0x9F85FF)
            ),
            FanMenuButton(
                id: "promote_user_id",
                image: UIImage(systemName: "person.fill.checkmark"),
                color: Color(val: 0xF55B58)
            )]
        // call before animation
        cell.fanMenu.onItemDidClick = { button in
            print("ItemDidClick: \(button.id)")
            
            if button.id == "block_user_id" {
                self.db.blockUserById(id: userId)
                print("blocking user\(userId)")
                cell.subType.text = String(3)
            }
        }
        // call after animation
        cell.fanMenu.onItemWillClick = { button in
            print("ItemWillClick: \(button.id)")
        }
        //FanMenu - Configure optional parameters
        //size of menu
        cell.fanMenu.radius = 15

        // distance between button and items
        cell.fanMenu.menuRadius = 30.0

        // animation duration
        cell.fanMenu.duration = 0.35

        // menu opening delay
        cell.fanMenu.delay = 0.05

        // interval for buttons in radians
        cell.fanMenu.interval = (0, 2.0 * .pi)

        // menu background color
        cell.fanMenu.menuBackground = Color.aliceBlue
    }
}
