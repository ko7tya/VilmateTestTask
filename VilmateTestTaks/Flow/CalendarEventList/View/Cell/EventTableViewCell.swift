//
//  EventTableViewCell.swift
//  VilmateTestTaks
//
//  Created by Kostyantin Ischenko on 6/26/19.
//  Copyright © 2019 Kostyantin Ischenko. All rights reserved.
//

import UIKit

class EventTableViewCell: UITableViewCell {

    @IBOutlet weak var eventTitle: UILabel!
    @IBOutlet weak var notificationButton: UIButton!
    @IBOutlet weak var attendeniesLabel: UILabel!
    
    var tapHandler: ((CalendarEvent) -> Void)?
    var event: CalendarEvent?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setup(with event: CalendarEvent) {
        self.event = event
        eventTitle.text = event.title
        notificationButton.isSelected = event.isNotificationSet
        if let attendencies = event.attendies {
            attendeniesLabel.text = "Attendencies: \((attendencies.map{ $0.email}).joined(separator: ","))"
        }else {
            attendeniesLabel.text = "No attendencies"
        }
    }
    
    @IBAction func setNotificaitonButtonAction(_ sender: UIButton) {
        guard var event = event else {
            return
        }
        sender.isSelected.toggle()
        event.shouldSendLocalPush = sender.isSelected
        event.isNotificationSet = sender.isSelected
        tapHandler?(event)
    }
    
}
