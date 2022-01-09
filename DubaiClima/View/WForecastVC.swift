//
//  ViewController.swift
//  DubaiClima
//
//  Created by melaabd on 1/9/22.
//

import UIKit

class WForecastVC: UIViewController {
    
    @IBOutlet weak var forecastTableView: UITableView!
    
    var forecastVM: WForecastVM?
    
    /// indecator for API calls
    lazy var activityIndicatorView: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(style: .large)
        aiv.translatesAutoresizingMaskIntoConstraints = false
        return aiv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        forecastVM = WForecastVM()
        forecastVM?.bindingDelegate = self
        configureProgress()
        forecastVM?.loadWeatherData()
    }


    /// override progress configration regerding to need in this VC
    func configureProgress() {
        view.addSubview(activityIndicatorView)
        activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        /// show the indecator while reload the data
        forecastVM?.showProgress = {
            onMain { [weak self] in
                self?.view.isUserInteractionEnabled = false
                self?.activityIndicatorView.startAnimating()
            }
        }
        
        /// hide the indecator after finish laoding the data
        forecastVM?.hideProgress = {
            onMain { [weak self] in
                self?.view.isUserInteractionEnabled = true
                self?.activityIndicatorView.stopAnimating()
            }
        }
    }
}

// MARK: - conform with forecastTableView protocols
extension WForecastVC: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return forecastVM?.detailsCellVM != nil ? 1 : 0
        default:
            return forecastVM?.daysForeCastCellsVM?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: DetailsTVCell.self)) as? DetailsTVCell ?? DetailsTVCell()
            cell.detailsVM = forecastVM?.detailsCellVM
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: DayForecastTVCell.self)) as? DayForecastTVCell ?? DayForecastTVCell()
            cell.dayForecastVM = forecastVM?.daysForeCastCellsVM?[indexPath.row]
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}


// MARK: - conform with BindingVVMDelegate protocol
extension WForecastVC: BindingVVMDelegate {
    func reloadData() {
        onMain { [weak self] in
            self?.forecastTableView.reloadData()
        }
    }
    
    func notifyFailure(msg: String) {
        let alert = UIAlertController(title: "Error", message: msg, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "Dismiss", style: .cancel)
        alert.addAction(dismissAction)
        onMain { [weak self] in
            self?.present(alert, animated: true)
        }
    }
}

