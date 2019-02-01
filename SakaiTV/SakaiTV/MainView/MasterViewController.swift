//
//  MasterViewController.swift
//  SakaiTV
//
//  Created by yuyuanyuan on 11/9/18.
//  Copyright © 2018 yuyuanyuan. All rights reserved.
//

import UIKit

/* This class is used to display master view in the master-detail view.
 * It will display a tableView on the left to show each section
 */

protocol ItemSelectionDelegate: class {
    func itemSelected(_ newItem: String)
}

class MasterViewController: UITableViewController {
    
   // weak var delegate: MonsterSelectionDelegate?


    @IBOutlet var myTableView: UITableView!
    @IBOutlet var GradientView: UIImageView!
    weak var delegate: ItemSelectionDelegate?
    var detailViewController: DetailViewController? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: DUKE,
            NSAttributedString.Key.font: UIFont(name: "Harry P", size: 95)!
        ]
        GradientView.image = UIImage(named: "MegaTron.jpg")
        GradientView.contentMode = UIView.ContentMode.scaleAspectFill
        //GradientView.clipsToBounds = true
        myTableView.backgroundView = GradientView
       // myTableView.backgroundView?.contentMode = UIView.ContentMode.scaleAspectFill
      //  myTableView.backgroundView?.clipsToBounds = true
        animateBackgroundColor()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source
    
    func animateBackgroundColor() {
        UIView.animate(withDuration: 10, delay: 0, options: [.autoreverse, .curveLinear, .repeat], animations:{
            let z =  0 - (self.myTableView.backgroundView?.frame.height ?? 0 - self.view.frame.height)
            self.myTableView.backgroundView?.transform = CGAffineTransform(translationX: 0, y: z)
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let object = gradeitems[indexPath.row]
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = object
                //controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
               // controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
    //     #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return gradeitems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = gradeitems[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          let selectedItem = gradeitems[indexPath.row]
          delegate?.itemSelected(selectedItem)
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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

}
