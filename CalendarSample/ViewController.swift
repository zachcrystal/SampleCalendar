//
//  ViewController.swift
//  CalendarSample
//
//  Created by Zach Crystal on 2018-07-09.
//  Copyright © 2018 Zach Crystal. All rights reserved.
//

import UIKit

class AppointmentsController: UIViewController {
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Appointments"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 36)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let titleIcon = UIImageView(image: #imageLiteral(resourceName: "LargeCalendar"))
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.layer.cornerRadius = 10
        collectionView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cellId")
        collectionView.register(AppointmentCalendarHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headerId")
        collectionView.alwaysBounceVertical = true
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        view.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 80).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        
        titleIcon.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleIcon)
        titleIcon.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor).isActive = true
        titleIcon.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        
        view.addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -8).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }
    
    private var shadowLayer: CAShapeLayer!
    private var cornerRadius: CGFloat = 10.0
    private var fillColor: UIColor = .clear
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if shadowLayer == nil {
            shadowLayer = CAShapeLayer()
            
            shadowLayer.path = UIBezierPath(roundedRect: collectionView.frame, cornerRadius: cornerRadius).cgPath
            
            shadowLayer.fillColor = fillColor.cgColor
            
            shadowLayer.shadowColor = UIColor.black.cgColor
            shadowLayer.shadowPath = shadowLayer.path
            shadowLayer.shadowOffset = CGSize(width: 0.0, height: 6.0)
            shadowLayer.shadowOpacity = 0.25
            shadowLayer.shadowRadius = 14
            
            view.layer.insertSublayer(shadowLayer, at: 0)
        }
    }
}

extension AppointmentsController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath)
        cell.backgroundColor = UIColor(red:0.95, green:0.95, blue:0.95, alpha:1.00)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerId", for: indexPath) as! AppointmentCalendarHeader
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
}
