//
//  SystemPermission.swift
//  SystemPermissionSwift
//
//  Created by 薛涛 on 2019/6/28.
//  Copyright © 2019 薛涛. All rights reserved.
//

import UIKit
import Photos
import AssetsLibrary
import CoreLocation
import AVFoundation


// MARK: 判断相册权限是否开启
///
/// - Parameter action: 回调相册开启状态
func openAlbumPermission(action :@escaping ((Bool)->())) {
    var isOpenAlbum = true
    let authStatus = PHPhotoLibrary.authorizationStatus()
    if authStatus == PHAuthorizationStatus.restricted || authStatus == PHAuthorizationStatus.denied {
        isOpenAlbum = false
    }
    action(isOpenAlbum)
}

// MARK: 判断相机权限是否开启
///
/// - Parameter action: 回调相机开启状态
func openCameraPermission(action :@escaping ((Bool)->())) {
    let isOpenCamera = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
    if isOpenCamera == AVAuthorizationStatus.notDetermined {
        AVCaptureDevice.requestAccess(for: AVMediaType.video) { (permission) in
            action(permission)
        }
    } else if isOpenCamera == AVAuthorizationStatus.restricted || isOpenCamera == AVAuthorizationStatus.denied {
        action(false)
    } else {
        action(true)
    }
}

// MARK: 判断麦克风权限是否开启
///
/// - Parameter action: 回调麦克风开启状态
func openMicrophonePermission(action :@escaping ((Bool)->())) {
    let isOpenMicrophone = AVAudioSession.sharedInstance().recordPermission
    if isOpenMicrophone == AVAudioSession.RecordPermission.undetermined {
        AVAudioSession.sharedInstance().requestRecordPermission { (permission) in
            action(permission)
        }
    } else if isOpenMicrophone == AVAudioSession.RecordPermission.denied || isOpenMicrophone == AVAudioSession.RecordPermission.undetermined {
        action(false)
    } else {
        action(true)
    }
}

// MARK: 判断定位权限是否开启
///
/// - Parameter action: 回调定位开启状态
func openLocationPermission(action :@escaping((Bool)->())) {
    var isOpenLocation = false
    if CLLocationManager.locationServicesEnabled() || CLLocationManager.authorizationStatus() != .denied {
        isOpenLocation = true
    }
    action(isOpenLocation)
}

// MARK: 跳转系统设置界面
func openSystemSetting() {
    let url = URL(string: UIApplication.openSettingsURLString)
    let alertController = UIAlertController(title: "需要访问系统权限", message: "立即去开启？", preferredStyle: .alert)
    let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
    let sureAction = UIAlertAction(title: "确定", style: .default) { (action) in
        if UIApplication.shared.canOpenURL(url!) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url!, options: [:], completionHandler: { (success) in
                    
                })
            } else {
                UIApplication.shared.canOpenURL(url!)
            }
        }
    }
    
    alertController.addAction(cancelAction)
    alertController.addAction(sureAction)
    UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
}
