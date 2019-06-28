//
//  ViewController.swift
//  VilmateTestTaks
//
//  Created by Kostyantin Ischenko on 6/26/19.
//  Copyright © 2019 Kostyantin Ischenko. All rights reserved.
//

import UIKit

class CalendarEventsListViewController: UIViewController {
    
    var viewModel: CalendarEventListViewModelType!
    var coordinator: CalendarEventListCoordinatorType!
    
    var dataSource: [CalendarEvent] = [] {
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        viewModel.fetchEventsFromCalendar { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let events):
                self.updateDataSource(with: events)
            case .failure:
                //show some error
                break
            }
        }
        
        viewModel.userTapOnNotification = { [weak self] id in
            guard let self = self else {
                return
            }
            guard let event = self.viewModel.getEvent(with: id) else {
                return
            }
            self.coordinator.showDetail(with: event)
        }
        
    }
    //Updating dataSource and set localnotification
    private func updateDataSource(with events: [CalendarEvent]) {
        viewModel.getPendingNotificationIds { [weak self] (ids) in
            guard let self = self else {
                return
            }
            self.dataSource.append(contentsOf: events)
            
            for (index, value) in self.dataSource.enumerated() {
                var newValue = value
                if ids.contains(value.id) || value.shouldSendLocalPush {
                    newValue.isNotificationSet = true
                    self.dataSource[index] = newValue
                }
            }
        }
    }
    
    //Add or remove Local notificaiton
    private func handle(event: CalendarEvent) {
        
        if event.isNotificationSet {
            viewModel.scheduleNotification(from: event)
        } else {
            viewModel.removeNotification(for: event)
        }
        
        if let index = dataSource.firstIndex(where: {$0.id == event.id}) {
            dataSource[index] = event
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension CalendarEventsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let event = dataSource[indexPath.row]
        coordinator.showDetail(with: event)
    }
}

extension CalendarEventsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EventTableViewCell", for: indexPath) as? EventTableViewCell else {
            return UITableViewCell()
        }

        let event = dataSource[indexPath.row]
        cell.setup(with: event)
        cell.tapHandler = { [weak self] event in
            guard let self = self else { return }
            self.handle(event: event)
        }
        return cell
    }
    
    
}

