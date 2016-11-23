//
//  weekReusableView.swift
//  test2
//
//  Created by Alex on 11/10/16.
//  Copyright © 2016 Alex. All rights reserved.
//

import UIKit

class weekReusableView: UICollectionReusableView {
    internal var calendar: Calendar = .current
    internal var dates: [Date]! = []
    internal var components: DateComponents!
    public var selectedIndex = IndexPath(row: 0, section: 0)
    let weekday = 5
    @IBOutlet weak var collectionView: UICollectionView!
    
    public var highlightColor = UIColor(red: 0/255.0, green: 199.0/255.0, blue: 194.0/255.0, alpha: 1)
    
    public var darkColor = UIColor(red: 0, green: 22.0/255.0, blue: 39.0/255.0, alpha: 1)
    
    override func awakeFromNib() {
        let layout = collectionView?.collectionViewLayout  as! UICollectionViewFlowLayout
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        //        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        let columns = CGFloat(weekday)
        let width =  floor(bounds.width / columns) - 1
        layout.itemSize = CGSize(width: width, height: width)
    }
    
    
    public override func layoutSubviews() {
        super.layoutSubviews()
       
        configureView()
    }
    
    
    private func configureView() {
        
        let minimumDate =  Date(timeIntervalSinceNow: 3600 * 24 * -10)
        let maximumDate =  Date(timeIntervalSinceNow: 3600 * 24 * 10)
            fillDates(fromDate: minimumDate, toDate: maximumDate)
        
        
    }
    
    
    
    func fillDates(fromDate: Date, toDate: Date) {
        
        var dates: [Date] = []
        var days = DateComponents()
        
        var dayCount = 0
        repeat {
            days.day = dayCount
            dayCount += 1
            guard let date = calendar.date(byAdding: days, to: fromDate) else {
                break;
            }
            if date.compare(toDate) == .orderedDescending {
                break
            }
            dates.append(date)
        } while (true)
        
        self.dates = dates
        collectionView.reloadData()
        
    }
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        alignScrollView(scrollView)
    }
    
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            alignScrollView(scrollView)
        }
    }
    
    func alignScrollView(_ scrollView: UIScrollView) {
        if let collectionView = scrollView as? UICollectionView {
            let centerPoint = CGPoint(x: 10 + collectionView.contentOffset.x, y: 50);
            if let indexPath = collectionView.indexPathForItem(at: centerPoint) {
                // automatically select this item and center it to the screen
                // set animated = false to avoid unwanted effects
                collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .top)
                if let cell = collectionView.cellForItem(at: indexPath) {
                    let offset = CGPoint(x: cell.center.x - cell.contentView.frame.width / 2, y: 0)
                    collectionView.setContentOffset(offset, animated: false)
                }

                selectedIndex = indexPath
            }
        }
    }
    
}



extension weekReusableView: UICollectionViewDataSource, UICollectionViewDelegate {
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(dates.count)
        return dates.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "weekday", for: indexPath) as! DateCollectionViewCell
        
        let date = dates[indexPath.item]
        
        cell.isSelected = selectedIndex == indexPath ? true : false
        
        cell.populateItem(date: date, highlightColor: highlightColor, darkColor: darkColor)
        
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath
        collectionView.reloadData()
       
        
    }
    
    func scrollToItem(at indexPath:IndexPath) {
        
        if selectedIndex != indexPath {
            selectedIndex = indexPath
            collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
        }
        
    }
    
    
}
