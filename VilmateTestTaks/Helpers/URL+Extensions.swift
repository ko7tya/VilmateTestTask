//
//  URL+Extensions.swift
//  VilmateTestTaks
//
//  Created by Kostyantin Ischenko on 6/27/19.
//  Copyright © 2019 Kostyantin Ischenko. All rights reserved.
//

import Foundation

extension URL {
    var email: String? {
        return scheme == "mailto" ? URLComponents(url: self, resolvingAgainstBaseURL: false)?.path : nil
    }
}
