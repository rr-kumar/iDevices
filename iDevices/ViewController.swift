//
//  ViewController.swift
//  iDevices
//
//  Created by Apple on 22/11/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    

    @IBOutlet weak var tableview: UITableView!
    
    var devices:[Device] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        tableview.dataSource = self
        tableview.delegate = self
            }
    
    override func viewWillAppear(_ animated: Bool) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do {
         devices = try context.fetch(Device.fetchRequest())
            tableview.reloadData()
            
        }catch{
            
        
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return devices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        let mydevice = devices[indexPath.row]
        cell.textLabel?.text = mydevice.title
        cell.imageView?.image = UIImage(data: mydevice.image!)
            return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mydevice = devices[indexPath.row]
        performSegue(withIdentifier: "deviceSegue", sender: mydevice)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextVC = segue.destination as! DeviceViewController
        nextVC.iDevice = sender as? Device
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

