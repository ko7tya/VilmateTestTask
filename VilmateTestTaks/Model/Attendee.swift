//
//  Attendee.swift
//  VilmateTestTaks
//
//  Created by Kostyantin Ischenko on 6/27/19.
//  Copyright © 2019 Kostyantin Ischenko. All rights reserved.
//

import Foundation
import EventKit

struct Attendee {
    let email: String
    let name: String
    init(from ekParticipant: EKParticipant) {
        name = ekParticipant.name ?? "no name"
        email = ekParticipant.url.email ?? "no email"
    }
}
