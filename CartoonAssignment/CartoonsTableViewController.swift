//
//  CartoonsTableViewController.swift
//  CartoonAssignment
//
//  Created by iOS on 21/09/19.
//  Copyright © 2019 in.bitcode. All rights reserved.
//

import UIKit

class CartoonsTableViewController: UITableViewController {
    
    var cartoonarray:[Cartoons]=[]
    var queue:DispatchQueue!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        queue=DispatchQueue(label: "download")
        
        tableView.register(UINib.init(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")

        let str="http://bitcodetech.in/android/webservices/cartoons.php?cmd=get&type=all"
        
        var urlrequest=URLRequest(url: URL(string: str)!)
        urlrequest.httpMethod="GET"
        
        let conf=URLSessionConfiguration.default
        let sessionobj=URLSession(configuration: conf)
        let task=sessionobj.dataTask(with: urlrequest) { (data, response, error) in
            
            
           let resultarray=try!JSONSerialization.jsonObject(with: data!, options: .allowFragments)as! NSArray
            
            for item in resultarray{
                
                let dicobj=item as! NSDictionary
                let cname=dicobj.value(forKey: "name")as! String
                let cimgname=dicobj.value(forKey: "imageurl")as! String
                let ccompanyname=dicobj.value(forKey: "company")as! String
                
                let dobdic=dicobj.value(forKey: "dob")as! NSDictionary
                let d=dobdic.value(forKey: "day")as! Int
                let m=dobdic.value(forKey: "mon")as! Int
                let y=dobdic.value(forKey: "year")as! Int
                
                let cartoonObj=Cartoons()
                cartoonObj.cartoonname=cname
                cartoonObj.cartooncompanyname=ccompanyname
                cartoonObj.cartoonImage=cimgname
                cartoonObj.cartoondob=String.init(format: "d-%d m-%d y-%d", d,m,y)
                
                self.cartoonarray.append(cartoonObj)
                
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }
        
        task.resume()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartoonarray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)as! CustomTableViewCell


        let cobj=cartoonarray[indexPath.row]
        
        cell.namelbl.text=cobj.cartoonname
        cell.companylbl.text=cobj.cartooncompanyname
        cell.doblbl.text=cobj.cartoondob
        cell.indicator.startAnimating()
    
       
        queue.async {
            
            let str=cobj.cartoonImage
            let url=URL(string: str)
            let data=try! Data.init(contentsOf: url!)
            let img=UIImage.init(data: data)
            
            DispatchQueue.main.async {
                
                cell.indicator.stopAnimating()
                cell.cimgview.image=img
            }
        }
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 130
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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
