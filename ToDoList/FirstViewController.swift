//
//  FirstViewController.swift
//  ToDoList
//
//  Created by 林奕德 on 2018/4/1.
//  Copyright © 2018年 AppsAdamLin. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent //調淡
    }
    
    var toDos = UserDefaults.standard.stringArray(forKey: "todos") ?? [String]()
    
    @IBOutlet weak var myTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.dataSource = self
        myTableView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1 //一項
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDos.count //三列
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell =  tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = toDos[indexPath.row]
        cell.textLabel?.textColor = .white //字色
        cell.textLabel?.font = UIFont(name: "arial", size: 24) //字型
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
           // indexPath.row 刪除這個array成員的資料
            toDos.remove(at: indexPath.row) //delete
           UserDefaults.standard.set(toDos,forKey: "todos") //儲存資料
            myTableView.reloadData()//在重整
        }
        
    }
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        if  let secondViewController = tabBarController?.viewControllers?[1] as? SecondViewController{
          secondViewController.inforFromViewOne = indexPath.row
        }
        
        tabBarController?.selectedIndex = 1
        
    }
}

