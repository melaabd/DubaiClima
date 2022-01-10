//
//  HourForecastCVCell.swift
//  DubaiClima
//
//  Created by melaabd on 1/9/22.
//

import UIKit

class HourForecastCVCell: UICollectionViewCell {
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var conditionLbl: UILabel!
    @IBOutlet weak var tempLbl: UILabel!
    
    
    var hourForecastVM:HourForecastCellVM? {
        didSet {
            updateCellInfo()
        }
    }
    
    private func updateCellInfo() {
        onMain { [weak self] in
            guard let self = self, let vm = self.hourForecastVM else { return }
            self.timeLbl.text = vm.timeString ?? ""
            self.tempLbl.text = Keeper.temperatureUnit == .fahrenheit ?  (vm.temp?.format() ?? "") : (vm.temp?.celciusFormat() ?? "")
            self.conditionLbl.text = vm.weather?.weatherDescription
        }
    }
    
}
