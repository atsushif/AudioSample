//
//  Config.swift
//  AudioSample
//
//  Created by matuilab on 2020/09/14.
//  Copyright © 2020 matuilab. All rights reserved.
//

import UIKit



class Config: UIViewController {
    var resultHandler: ((Bool) -> Void)?
    var config_bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config.setOn(config_bool, animated: false)
    }
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var config: UISwitch!
    @IBAction func config_func(_ sender: Any) {
        config_bool = (sender as AnyObject).isOn
        if let handler = self.resultHandler {
            // 入力値を引数として渡された処理の実行
            handler(config_bool)
        }
    }
}
