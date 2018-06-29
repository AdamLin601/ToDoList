//
//  SecondViewController.swift
//  ToDoList
//
//  Created by 林奕德 on 2018/4/1.
//  Copyright © 2018年 AppsAdamLin. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController,UITextFieldDelegate{
    
    var inforFromViewOne:Int?
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent //調淡
    }
    @IBOutlet weak var myButton: UIButton!
    @IBOutlet weak var myTextInput: UITextField!
    @IBAction func textFieldDoChanged(_ sender: UITextField) {
        if sender.text != ""{
            myButton.setTitle("OK", for: .normal)
        }else{
            myButton.setTitle("Back", for: .normal)
        }
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        if let text = myTextInput.text{
            guard let firstViewController = tabBarController?.viewControllers?[0] as? FirstViewController else{return}
            if text != ""{
                if inforFromViewOne != nil{
                    firstViewController.toDos[inforFromViewOne!] = text
                    inforFromViewOne = nil
                }else{
                    firstViewController.toDos.append(text)//將text加入第一頁 toDos陣列
                }
                firstViewController.myTableView.reloadData()//重新reload
                UserDefaults.standard.set(firstViewController.toDos,forKey: "todos")
            }else{
                if inforFromViewOne != nil {
                    firstViewController.toDos.remove(at: inforFromViewOne!)
                    UserDefaults.standard.set(firstViewController.toDos,forKey: "todos")
                    inforFromViewOne = nil
                }
            }
        }
        myTextInput.text = ""
        myButton.setTitle("Back", for: .normal)
        self.tabBarController?.selectedIndex = 0 //chose first one view(回第一個面)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTextInput.becomeFirstResponder() //顯示鍵盤
        myTextInput.delegate = self //問delegate按return時如何做用
        
       
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if inforFromViewOne != nil{
            if let firstViewController =  tabBarController?.viewControllers?[0] as? FirstViewController{
                myTextInput.text = firstViewController.toDos[inforFromViewOne!]
                myButton.setTitle("OK", for: .normal)
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        buttonPressed(UIButton()) //呼叫 重複buttonPressed內函式功能 參數自訂一個UIButton()
        return true
    }

}

