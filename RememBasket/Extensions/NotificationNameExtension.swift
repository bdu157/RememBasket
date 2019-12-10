//
//  NotificationExtension.swift
//  RememBasket
//
//  Created by Dongwoo Pae on 11/19/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

import Foundation

extension Notification.Name {
    static var needtoResetData = Notification.Name("needtoResetData")
    static var needtoReloadData = Notification.Name("needtoReloadData")
    static var needtoFetchImage = Notification.Name("needtoFetchImage")
    static var needtoSetUpData = Notification.Name("needtoremoveURL")
}
