//
//  ForecastTVCell.swift
//  DubaiClima
//
//  Created by melaabd on 1/9/22.
//

import UIKit

class DayForecastTVCell: UITableViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var visualView: UIVisualEffectView!
    @IBOutlet weak var dayLbl: UILabel!
    @IBOutlet weak var hourForecastCollectionView: UICollectionView!
    
    var dayForecastVM: DayForecastCellVM? {
        didSet {
            updateCellInfo()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        visualView.layer.cornerRadius = 12
        visualView.clipsToBounds = true
    }
    
    private func updateCellInfo() {
        onMain { [weak self] in
            guard let self = self else { return }
            self.dayLbl.text = self.dayForecastVM?.day
            UIView.transition(with: self.hourForecastCollectionView,
                              duration: 0.35,
                              options: .transitionCrossDissolve,
                              animations: { self.hourForecastCollectionView.reloadData() })
        }
    }
    
}

// MARK: - Conform hourForecastCollectionView protocols
extension DayForecastTVCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let noOfCells = dayForecastVM?.hoursForecastVM?.count ?? 0
        noOfCells == 0 ? collectionView.setEmptyView("No Forecast Found") : collectionView.setEmptyView()
        return noOfCells
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: HourForecastCVCell.self), for: indexPath) as? HourForecastCVCell ?? HourForecastCVCell()
        cell.hourForecastVM = dayForecastVM?.hoursForecastVM?[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 100)
    }
}
