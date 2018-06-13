//
//  MonthView.swift
//  TeamProject
//
//  Created by apple11 on 2018. 6. 1..
//  Copyright © 2018년 COMP420. All rights reserved.
//

import UIKit
protocol MonthViewDelegate: class{
    func didChangeMonth(monthIndex: Int, year: Int)
}
struct DATE{
    static var monthsArr = ["1월", " 2월", "3월", "4월", "5월",
                     "6월", "7월", "8월", "9월", "10월",
                     "11월", "12월"]
}
class MonthView: UIView {
    var monthsArr = ["1월", " 2월", "3월", "4월", "5월",
                     "6월", "7월", "8월", "9월", "10월",
                     "11월", "12월"]
    var currentMonthIndex = 0
    var currentYear: Int = 0
    var delegate: MonthViewDelegate?
    
    override init(frame: CGRect){
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        currentMonthIndex = Calendar.current.component(.month, from: Date()) - 1
        currentYear = Calendar.current.component(.year, from: Date())
        
        setupViews()
        
        btnLeft.isEnabled = false
    }
    @objc func btnLeftRightAction(sender: UIButton){
        if sender == btnRight{
            currentMonthIndex += 1
            if currentMonthIndex > 11{
                currentMonthIndex = 0
                currentYear += 1
            }
        }else{
            currentMonthIndex -= 1
            if currentMonthIndex < 0 {
                currentYear -= 1
                currentMonthIndex = 11
            }
        }
        lblName.text = "\(currentYear) \(monthsArr[currentMonthIndex])"
        delegate?.didChangeMonth(monthIndex: currentMonthIndex, year: currentYear)
    }
    let lblName: UILabel = {
        let lbl = UILabel()
        lbl.text="Default Month Year text"
        lbl.textColor = Style.monthViewLblColor
        lbl.textAlignment = .center
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    let btnRight: UIButton = {
        let btn=UIButton()
        btn.setTitle(">", for: .normal)
        btn.setTitleColor(Style.monthViewBtnRightColor, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints=false
        btn.addTarget(self, action: #selector(btnLeftRightAction(sender:)), for: .touchUpInside)
        return btn
    }()
    
    let btnLeft: UIButton = {
        let btn=UIButton()
        btn.setTitle("<", for: .normal)
        btn.setTitleColor(Style.monthViewBtnLeftColor, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints=false
        btn.addTarget(self, action: #selector(btnLeftRightAction(sender:)), for: .touchUpInside)
        btn.setTitleColor(UIColor.lightGray, for: .disabled)
        return btn
    }()
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupViews(){
        self.addSubview(lblName)
        lblName.topAnchor.constraint(equalTo: topAnchor).isActive = true
        lblName.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        lblName.widthAnchor.constraint(equalToConstant: 150).isActive = true
        lblName.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        lblName.text = "\(currentYear) \(monthsArr[currentMonthIndex])"
        
        self.addSubview(btnRight)
        btnRight.topAnchor.constraint(equalTo: topAnchor).isActive = true
        btnRight.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        btnRight.widthAnchor.constraint(equalToConstant: 50).isActive = true
        btnRight.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        
        self.addSubview(btnLeft)
        btnLeft.topAnchor.constraint(equalTo: topAnchor).isActive = true
        btnLeft.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        btnLeft.widthAnchor.constraint(equalToConstant: 50).isActive = true
        btnLeft.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
    }

}
