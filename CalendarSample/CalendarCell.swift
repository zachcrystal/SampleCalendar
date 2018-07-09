//
//  CalendarCell.swift
//  CalendarSample
//
//  Created by Zach Crystal on 2018-07-09.
//  Copyright © 2018 Zach Crystal. All rights reserved.
//

import UIKit
import JTAppleCalendar

class CalendarCell: JTAppleCell {
    
    let selectedView = UIView()
    
    var dayLabel: UILabel = {
        let label = UILabel()
        label.text = "123"
        //        label.textColor = .grayText
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        selectedView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(selectedView)
        selectedView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        selectedView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        selectedView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        selectedView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        
        addSubview(dayLabel)
        dayLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        dayLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
