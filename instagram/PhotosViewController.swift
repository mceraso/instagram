//
//  PhotosViewController.swift
//  
//
//  Created by Michael Ceraso on 2/4/16.
//
//

import UIKit
import AFNetworking

class PhotosViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var instanarynary: [NSDictionary]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 320;

        let clientId = "e05c462ebd86446ea48a5af73769b602"
        let url = NSURL(string:"https://api.instagram.com/v1/media/popular?client_id=\(clientId)")
        let request = NSURLRequest(URL: url!)
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate:nil,
            delegateQueue:NSOperationQueue.mainQueue()
        )
        
        let task : NSURLSessionDataTask = session.dataTaskWithRequest(request,
            completionHandler: { (dataOrNil, response, error) in
                if let data = dataOrNil {
                    if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(
                        data, options:[]) as? NSDictionary {
                            /* NSLog("response: \(responseDictionary)") */
                            
                            //Code copied from my movies App:
                            
                            self.instanarynary = responseDictionary["data"] as! [NSDictionary]
                            self.tableView.reloadData()
                    }
                }
        });
        task.resume()

        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
    if let instanarynary = instanarynary {
        return instanarynary.count
        } else {
            return 0
    }}
    
func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
    let cell = tableView.dequeueReusableCellWithIdentifier("PhotoCell", forIndexPath: indexPath) as! InstaTableViewCell
    
    let instanary = instanarynary![indexPath.row]
    
    //Code copied from Student Leader Saul Soto and Monte9:
    if let username = instanary.valueForKeyPath("user.username") as? String {
        cell.usernameText.text = username
    }
    else {
        cell.usernameText.text = "0"
    }
    
    let profilePhotoPath = NSURL(string: instanary.valueForKeyPath("user.profile_picture") as! String)
    cell.profilePhoto.setImageWithURL(profilePhotoPath!)
    cell.profilePhoto.layer.cornerRadius = cell.profilePhoto.frame.height/2;
    
    let TopPhotoPath = NSURL(string: instanary.valueForKeyPath("images.standard_resolution.url") as! String)
    cell.TopPhoto.setImageWithURL(TopPhotoPath!)
    
    return cell
    }
}
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */