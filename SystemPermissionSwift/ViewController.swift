//
//  ViewController.swift
//  SystemPermissionSwift
//
//  Created by 薛涛 on 2019/6/28.
//  Copyright © 2019 薛涛. All rights reserved.
//

import UIKit
import SystemConfiguration
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpButtons()
    }
    
    func setUpButtons() {
        let array = ["相机权限", "相册权限", "麦克风权限", "定位权限"]
        for i in 0..<array.count {
            let button: UIButton = UIButton.init(type: .custom)
            button.tag = i + 100
            button.frame = CGRect(x: 0, y: 100+60*CGFloat(i), width: self.view.frame.size.width, height: 40)
            button.setTitle(array[i], for: .normal)
            button.setTitleColor(UIColor.blue, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
            button.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.center
            button.addTarget(self, action: #selector(buttonCliked(_:)), for: .touchUpInside)
            self.view.addSubview(button)
        }
    }
    
    @objc func buttonCliked(_ sender: UIButton) {
        switch sender.tag {
        case 100:
            openCameraPermission { (permission) in
                if permission {
                    print("相机权限已开启")
                } else {
                    openSystemSetting()
                }
            }
            break
        
        case 101:
            openAlbumPermission { (permission) in
                if permission {
                    print("相册权限已开启")
                } else {
                    openSystemSetting()
                }
            }
            break
            
        case 102:
            openMicrophonePermission { (permission) in
                if permission {
                    print("麦克风权限已开启")
                } else {
                    openSystemSetting()
                }
            }
            break
            
        case 103:
            openLocationPermission { (permission) in
                if permission {
                    print("定位权限已开启")
                } else {
                    openSystemSetting()
                }
            }
            break
            
        default:
            break
        }
    }
}

