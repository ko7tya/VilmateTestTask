//
//  CalendarEventDetailViewController.swift
//  VilmateTestTaks
//
//  Created by Kostyantin Ischenko on 6/28/19.
//  Copyright © 2019 Kostyantin Ischenko. All rights reserved.
//

import UIKit

class EventDetailViewController: UIViewController {
    
    var eventId: String!
    var viewModel: EventDetailViewModelType!
    var coordinator: EventDetailCoordinatorType!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startFlow()
    }
    
    func startFlow() {
        guard let event = viewModel.getEvent(with: eventId) else {
            return
        }
        updateUI(for: event)
    }
    
    func updateUI(for event: CalendarEvent) {
        titleLabel.text = event.title
        descriptionLabel.text = event.description ?? "No description"
    }

}
