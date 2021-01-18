//
//  HomeController.swift
//  hello_world
//
//  Created by tientran on 21/12/2020.
//

import UIKit
import MapKit
import FirebaseAuth

private let reuseIdentifier = "LocationCell"

class HomeController: UIViewController {
    
    let mapView = MKMapView()
    let location = CLLocationManager()
    private let inputActivationView = LocationInputActivationView()
    private let locationInputView = LocationInputView()
    private let tableView =  UITableView()
    private final let locationInputViewHeight : CGFloat =  200
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        configureNavigation()
        checkLogin()
        locationServices()
        fetchUserData()
        
    }
    
    func fetchUserData()  {
        Service.share.fetchUserData { (user) in
            self.locationInputView.user = user
        }
    }
    
    func checkLogin()  {
        
        //        guard (UIWindow.key?.rootViewController as? HomeController) != nil else { return }
        
        if Auth.auth().currentUser?.uid == nil{
            DispatchQueue.main.async {
                let nav = UINavigationController(rootViewController: LoginController())
                self.present(nav, animated: true, completion: nil)
            }
        }
        else{
            print("uid : \(String(describing: Auth.auth().currentUser?.uid))" )
            configureUI()
        }
    }
    
    func signOut()  {
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    func configureNavigation()  {
        navigationController?.navigationBar.isHidden = true
    }
    
    func configureMap(){
        mapView.frame = view.frame
        view.addSubview(mapView)
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
    }
    
    func configureUI() {
        
        configureMap()
        
        view.addSubview(inputActivationView)
        inputActivationView.centerX(inView: view)
        inputActivationView.setDimensions(height: 40, width: view.frame.width - 64)
        inputActivationView.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 20)
        inputActivationView.alpha = 0
        inputActivationView.delegate = self
        UIView.animate(withDuration: 2) {
            self.inputActivationView.alpha = 1
        }
        
        configureTableView()
    }
    
    func configureLocationView()  {
        locationInputView.delegate = self
        view.addSubview(locationInputView)
        locationInputView.anchor(top:view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, height: locationInputViewHeight)
        locationInputView.alpha = 0
        
        UIView.animate(withDuration: 0.5) {
            self.locationInputView.alpha = 1
        } completion: { (_) in
            UIView.animate(withDuration: 0.5) {
                self.tableView.frame.origin.y = self.locationInputViewHeight
            }
        }
    }
    
    func configureTableView()  {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(LocationCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.rowHeight = 40
        let height = view.frame.height - locationInputViewHeight
        
        tableView.frame = CGRect(x: 0, y: view.frame.height, width: view.frame.width, height: height)
        
        view.addSubview(tableView)
        
    }
}

// Mark - LocationServices

extension HomeController : CLLocationManagerDelegate {
    
    func locationServices()  {
        location.delegate = self
        switch CLLocationManager().authorizationStatus {
        case .notDetermined:
            print("location not determined")
            location.requestWhenInUseAuthorization()
        case .denied, .restricted:
            print("location denied")
            break
        case .authorizedAlways:
            print("location authorized always")
            location.startUpdatingLocation()
            location.desiredAccuracy = kCLLocationAccuracyBest
        case .authorizedWhenInUse:
            print("location authorized in use")
        //            location.requestAlwaysAuthorization()
        default:
            print("unknow location")
            break
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        if manager.authorizationStatus == .authorizedWhenInUse {
            location.requestAlwaysAuthorization()
        }
        
    }
    
}

extension HomeController : LocationInputActivationViewDelegate {
    func presentLocationInputView() {
        inputActivationView.alpha = 0
        
        configureLocationView()
    }
}

extension HomeController : LocationInputViewDelegate {
    func dismissLocationView() {
        
        UIView.animate(withDuration: 0.5) {
            self.tableView.frame.origin.y = self.view.frame.height
        } completion: { (_) in
            self.locationInputView.removeFromSuperview()
            self.inputActivationView.alpha = 1
        }
    }
}

extension HomeController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Test title"
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return section == 0 ? 2 : 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! LocationCell
        
        return cell
    }
    
    
}
