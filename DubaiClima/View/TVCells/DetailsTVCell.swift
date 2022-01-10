//
//  DetailsTVCell.swift
//  DubaiClima
//
//  Created by melaabd on 1/9/22.
//

import UIKit

class DetailsTVCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    
    
    var detailsVM:DetailsCellVM? {
        didSet {
            updateCellInfo()
        }
    }
    
    @IBOutlet weak var cityNameLbl: UILabel!
    @IBOutlet weak var currentTempLbl: UILabel!
    @IBOutlet weak var weatherCondLbl: UILabel!
    @IBOutlet weak var maxTempLbl: UILabel!
    @IBOutlet weak var minTempLbl: UILabel!
    
    
    private func updateCellInfo() {
        onMain { [weak self] in
            guard let self = self, let vm = self.detailsVM else { return }
            self.cityNameLbl.text = vm.cityName
            self.currentTempLbl.text = Keeper.temperatureUnit == .fahrenheit ?  vm.temp?.format() : vm.temp?.celciusFormat()
            
            self.weatherCondLbl.text = vm.weather?.weatherDescription
            self.maxTempLbl.text = "H:\(Keeper.temperatureUnit == .fahrenheit ? (vm.maxTemp?.format() ?? "") : (vm.temp?.celciusFormat() ?? ""))"
            self.minTempLbl.text = "L:\(Keeper.temperatureUnit == .fahrenheit ? (vm.minTemp?.format() ?? "") : (vm.minTemp?.celciusFormat() ?? ""))"
        }
        
    }

}
