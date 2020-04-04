//
//  MainViewController.swift
//  FightCorona
//
//  Created by Wai Shan on 2/4/20.
//  Copyright © 2020 Wai Shan. All rights reserved.
//

import UIKit
import Kingfisher
import SwiftyGif

class MainViewController: UIViewController {

    // MARK: Outlet area
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: global variables area
    var world: WorldModel?
    var countries: [CountryModel]?
    var searchedCountries: [CountryModel]?
    var country: CountryModel?
    
    let busyView = UIActivityIndicatorView()
    var segmentedControl = UISegmentedControl(
        items: [localizedStrings.world, localizedStrings.countries]
    )
    var refreshControl = UIRefreshControl()
    var searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        busyView.stopAnimating()
    }
    
    private func setup() {
        self.title = Constant.PageTitle.home
        if let country = country {
            self.title = country.country
            let imageView = UIImageView()
            guard let flagURL = URL(string: country.countryInfo.flag ?? Constant.Defaults.emptyString) else { return }
            imageView.kf.setImage(with: flagURL, placeholder: UIImage(named: Constant.ImageName.defaultImage))
            imageView.contentMode = .scaleAspectFit
            imageView.clipsToBounds = true
            imageView.sizeToFit()
            tableView.tableHeaderView = imageView
        }
        tableViewSetup()
        addSearchController()
        addSegmentedControl()
        addPullToRefreshControl()
        addActivityIndicator()
        showHideBusyView(isNeedToShow: true)
        fetchData()
    }
    
}

//MARK: Network and data fetching layer
extension MainViewController {
    
    fileprivate func fetchWorldStatus() {
        APIClient.FetchWorldStatus()
            .done { response in
                self.world = response
                self.showHideBusyView(isNeedToShow: false)
                self.tableView.reloadData()
        } .catch { error in
            self.showHideBusyView(isNeedToShow: false)
            self.present(Utilities.showInfoAlert(title: localizedStrings.error, msg: error.localizedDescription, alertButtonTitle: localizedStrings.tryAgain, action: self.fetchData()), animated: true)
        }
    }
    
    fileprivate func fetchCountriesStatus() {
        APIClient.FetchCountriesStatus()
        .done { response in
            self.countries = response
            self.showHideBusyView(isNeedToShow: false)
            self.tableView.reloadData()
        } .catch { error in
            self.showHideBusyView(isNeedToShow: false)
            self.present(Utilities.showInfoAlert(title: localizedStrings.error, msg: error.localizedDescription, alertButtonTitle: localizedStrings.tryAgain, action: self.fetchData()), animated: true)
        }
    }
    
    private func fetchData() {
        prepareUIBeforeFetch(isBusy: true)
        fetchWorldStatus()
        fetchCountriesStatus()
    }
    
}

// MARK: UI
extension MainViewController {
    
    fileprivate func showHideBusyView(isNeedToShow: Bool) {
        busyView.isHidden = !isNeedToShow
        tableView.isHidden = isNeedToShow
        if refreshControl.isRefreshing && !isNeedToShow {
            refreshControl.endRefreshing()
        }
    }
    
    fileprivate func tableViewSetup() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
    }
    
    fileprivate func addSegmentedControl() {
        if country == nil {
            navigationItem.titleView = segmentedControl
            segmentedControl.selectedSegmentIndex = 0
            segmentedControl.addTarget(self, action: #selector(segmentedControlValueChange(_:)), for: .valueChanged)
            return
        }
    }
    
    fileprivate func addActivityIndicator() {
        if #available(iOS 12.0, *) {
            busyView.style = self.traitCollection.userInterfaceStyle == .dark ? .white : .gray
        } else {
            busyView.style = .gray
        }
        busyView.center = self.view.center
        self.view.addSubview(busyView)
        busyView.startAnimating()
    }

    fileprivate func addPullToRefreshControl() {
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: UIControl.Event.valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    fileprivate func addSearchController() {
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.searchBarStyle = .minimal
        definesPresentationContext = true
    }
    
    fileprivate func prepareUIBeforeFetch(isBusy: Bool) {
        showHideBusyView(isNeedToShow: isBusy)
        searchController.searchResultsUpdater = self
        if segmentedControl.selectedSegmentIndex == 1 {
            tableView.tableHeaderView = searchController.searchBar
        } else if segmentedControl.selectedSegmentIndex == 0 {
            do {
                let gif = try UIImage(gifName: Constant.ImageName.loading)
                let imageview = UIImageView(gifImage: gif)
                imageview.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
                imageview.contentMode = .scaleAspectFit
                imageview.clipsToBounds = true
                tableView.tableHeaderView = imageview
            } catch {
                print(error)
            }
        }
        tableView.reloadData()
    }
    
}

// MARK: Actions
extension MainViewController {
    
    @objc func segmentedControlValueChange(_ sender: UISegmentedControl) {
        if world == nil || countries == nil {
            fetchData()
            return
        }
        prepareUIBeforeFetch(isBusy: false)
    }
    
    @objc func refresh(_ sender: UIRefreshControl) {
       fetchData()
    }
    
}

// MARK: TableView
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let countriesCount = searchController.isActive && searchController.searchBar.text! != Constant.Defaults.emptyString ? searchedCountries?.count : countries?.count
        let infoCount = segmentedControl.numberOfSegments > 0 && segmentedControl.selectedSegmentIndex == 0 ? 6 : 10
        return segmentedControl.selectedSegmentIndex == 1 ? countriesCount ?? 0 : infoCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if segmentedControl.selectedSegmentIndex == 0 {
            guard let worldCell = tableView.dequeueReusableCell(withIdentifier: Constant.CellIdentifier.worldCell) as? WorldStatusTableViewCell else { return UITableViewCell() }
            worldCell.selectionStyle = .none
            worldCell.worldCellConfig(world, row: indexPath.row)
            return worldCell
        } else if segmentedControl.selectedSegmentIndex == 1 {
            guard let countriesCell = tableView.dequeueReusableCell(withIdentifier: Constant.CellIdentifier.countryCell) as? CountryStatusTableViewCell else { return UITableViewCell() }
            countriesCell.selectionStyle = .none
            let countryCell = searchController.isActive && searchController.searchBar.text! != Constant.Defaults.emptyString ? searchedCountries?[indexPath.row] : countries?[indexPath.row]
            countriesCell.config(countryCell)
            return countriesCell
        }
        guard let countryDetailCell = tableView.dequeueReusableCell(withIdentifier: Constant.CellIdentifier.worldCell) as? WorldStatusTableViewCell else { return UITableViewCell() }
        countryDetailCell.selectionStyle = .none
        countryDetailCell.countryDetailCellConfig(country, row: indexPath.row)
        return countryDetailCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return segmentedControl.selectedSegmentIndex == 1 ? 120 : 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if segmentedControl.selectedSegmentIndex == 1 {
            guard let viewController = UIStoryboard(name: Constant.StoryboardIdentifier.mainStroryboard, bundle: nil).instantiateViewController(withIdentifier: Constant.StoryboardIdentifier.mainView) as? MainViewController else { return }
            let countryData = searchController.isActive && searchController.searchBar.text! != Constant.Defaults.emptyString ? searchedCountries?[indexPath.row] : countries?[indexPath.row]
            viewController.country = countryData
            viewController.segmentedControl = UISegmentedControl(items: nil)
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
}

// MARK: Search
extension MainViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        if searchController.isActive && segmentedControl.selectedSegmentIndex == 1 {
            searchedCountries = countries?.filter({ (country : CountryModel) -> Bool in
                return country.country?.lowercased().contains( searchController.searchBar.text!.lowercased()) ?? true
            })
        }
        tableView.reloadData()
    }
    
}
