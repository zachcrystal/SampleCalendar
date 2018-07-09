//
//  AppointmentCalendarHeader.swift
//  CalendarSample
//
//  Created by Zach Crystal on 2018-07-09.
//  Copyright © 2018 Zach Crystal. All rights reserved.
//

import UIKit
import JTAppleCalendar

class AppointmentCalendarHeader: UICollectionViewCell {
    
    let monthLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 155/255, green: 155/255, blue: 155/255, alpha: 1.0)
        label.font = UIFont.systemFont(ofSize: 30)
        return label
    }()
    
    lazy var calendarView: JTAppleCalendarView = {
        let calendar = JTAppleCalendarView()
        calendar.backgroundColor = .white
        calendar.scrollDirection = .horizontal
        calendar.showsHorizontalScrollIndicator = false
        calendar.isPagingEnabled = true
        calendar.calendarDelegate = self
        calendar.calendarDataSource = self
        calendar.allowsMultipleSelection = false
        calendar.minimumLineSpacing = 0
        calendar.minimumInteritemSpacing = 0
        calendar.translatesAutoresizingMaskIntoConstraints = false
        return calendar
    }()
    
    let formatter = DateFormatter()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        calendarView.register(CalendarCell.self, forCellWithReuseIdentifier: "CustomCell")
        
        //        let nib = UINib(nibName: "CalendarCellView", bundle: nil)
        //        calendarView.register(nib, forCellWithReuseIdentifier: "CustomCell")
        
        setupConstraints()
        
        self.calendarView.visibleDates {[unowned self] (visibleDates: DateSegmentInfo) in
            self.setupViewsOfCalendar(from: visibleDates)
        }
    }
    
    private func setupConstraints() {
        //        addSubview(monthLabel)
        //        monthLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 6, paddingLeft: 36, paddingBottom: 0, paddingRight: 0, width: 0, height: 20)
        
        //        let dayStackView = createDaysStackView()
        //        dayStackView.backgroundColor = .green
        //        addSubview(dayStackView)
        //        dayStackView.anchor(top: monthLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 2, paddingLeft: 26, paddingBottom: 0, paddingRight: 26, width: 0, height: 0)
        
        addSubview(calendarView)
        //        calendarView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 26, paddingBottom: 12, paddingRight: 26, width: 0, height: 0)
        
        calendarView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        calendarView.leftAnchor.constraint(equalTo: leftAnchor, constant: 26).isActive = true
        calendarView.rightAnchor.constraint(equalTo: rightAnchor, constant: -26).isActive = true
        calendarView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12).isActive = true
        
    }
    
    func createDaysStackView() -> UIStackView {
        let days = ["SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"]
        var labels = [UILabel()]
        for day in days {
            let label = UILabel()
            label.text = day
            label.font = UIFont.systemFont(ofSize: 12)
            label.textColor = UIColor(red: 155/255, green: 155/255, blue: 155/255, alpha: 1.0)
            labels.append(label)
        }
        let stackView = UIStackView(arrangedSubviews: labels)
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        return stackView
    }
    
    func setupViewsOfCalendar(from visibleDates: DateSegmentInfo) {
        guard let startDate = visibleDates.monthDates.first?.date else {
            return
        }
        let month = Calendar.current.dateComponents([.month], from: startDate).month!
        let monthName = DateFormatter().monthSymbols[(month-1) % 12]
        // 0 indexed array
        let year = Calendar.current.component(.year, from: startDate)
        monthLabel.text = monthName + " " + String(year)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(view: JTAppleCell?, cellState: CellState) {
        guard let myCustomCell = view as? CalendarCell  else { return }
        handleCellTextColor(view: myCustomCell, cellState: cellState)
        handleCellSelection(view: myCustomCell, cellState: cellState)
    }
    
    func handleCellSelection(view: CalendarCell, cellState: CellState) {
        if cellState.isSelected && cellState.dateBelongsTo == .thisMonth {
            view.selectedView.backgroundColor = UIColor.red
            view.dayLabel.textColor = .white
        } else {
            view.selectedView.backgroundColor = UIColor.white
        }
    }
    func handleCellTextColor(view: CalendarCell, cellState: CellState) {
        if cellState.dateBelongsTo == .thisMonth {
            view.dayLabel.textColor = UIColor(red: 155/255, green: 155/255, blue: 155/255, alpha: 1.0)
        } else {
            view.dayLabel.textColor = UIColor(red: 226/255, green: 226/255, blue: 226/255, alpha: 1)
        }
    }
}

extension AppointmentCalendarHeader: JTAppleCalendarViewDelegate, JTAppleCalendarViewDataSource {
    func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        configureCell(view: cell, cellState: cellState)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "CustomCell", for: indexPath) as! CalendarCell
        configureCell(view: cell, cellState: cellState)
        cell.dayLabel.text = cellState.text
        
        return cell
    }
    
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        formatter.dateFormat = "yyyy MM dd"
        formatter.timeZone = Calendar.current.timeZone
        formatter.locale = Calendar.current.locale
        
        let startDate = formatter.date(from: "2018 01 01")!
        let endDate = formatter.date(from: "2030 02 01")!
        
        let parameters = ConfigurationParameters(startDate: startDate, endDate: endDate)
        
        return parameters
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        setupViewsOfCalendar(from: visibleDates)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        configureCell(view: cell, cellState: cellState)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        configureCell(view: cell, cellState: cellState)
    }
}

