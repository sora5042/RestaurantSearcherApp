//
//  ViewController.swift
//  RestaurantSercherApp
//
//  Created by 大谷空 on 2021/06/02.
//

import UIKit
import MapKit
import Alamofire
import Nuke

class SearchShopViewController: UIViewController {
    
    private var shopDetail: Shop?
    private var shopData = [Shop]()
    private var shopCount = Int()
    
    private var nameStringArray = [String]()
    private var shopImageStringArray = [String]()
    private var addressStringArray = [String]()
    private var accessStringArray = [String]()
    private var openStringArray = [String]()
    private var parkingStringArray = [String]()
    private var catchStringArray = [String]()
    private var indexNumber = Int()
    
    private var latValue = Double()
    private var lngValue = Double()
    
    private var locManager: CLLocationManager!
    private var pointAno: MKPointAnnotation = MKPointAnnotation()
    
    @IBOutlet weak private var searchWordTextField: UITextField!
    @IBOutlet weak private var searchButton: UIButton!
    @IBOutlet weak private var mkMapView: MKMapView!
    @IBOutlet weak private var searchResultButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupMap()
        searchButton.addTarget(self, action: #selector(tappedSearchButton), for: .touchUpInside)
        searchResultButton.addTarget(self, action: #selector(tappedSearchResultButton), for: .touchUpInside)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        fetchShopDataInfo()
    }
    
    // MARK: - Method
    @objc private func tappedSearchResultButton() {
        
        let shopSearchResultViewController = UIStoryboard(name: "SearchShopResult", bundle: nil).instantiateViewController(withIdentifier: "SearchShopResultViewController") as! SearchShopResultViewController
        
        shopSearchResultViewController.modalPresentationStyle = .fullScreen
        shopSearchResultViewController.shopData = shopData
        
        
        self.present(shopSearchResultViewController, animated: true, completion: nil)
    }
    
    @objc private func tappedSearchButton() {
        
        guard let searchText = searchWordTextField.text else { return }
        
        fetchSearchShopInfo(searchText: searchText)
        searchWordTextField.resignFirstResponder()
    }
    
    private func fetchShopDataInfo() {
        
        let params = [
            "lat": "\(latValue)",
            "lng": "\(lngValue)"
            
        ] as [String : Any]
        
        API.shared.request(params: params, type: ShopData.self) { (shop) in
            
            self.shopData = shop.results.shop
            self.shopCount = shop.results.shop.count
            self.addAnnotation()
        }
    }
    
    private func fetchSearchShopInfo(searchText: String) {
        
        let params = [
            
            "keyword": searchText,
            "lat": "\(latValue)",
            "lng": "\(lngValue)"
            
        ] as [String : Any]
        
        API.shared.request(params: params, type: ShopData.self) { (shop) in
            
            self.shopData = shop.results.shop
            self.shopCount = shop.results.shop.count
            self.addAnnotation()
        }
    }
    
    private func setupMap() {
        
        locManager = CLLocationManager()
        locManager.delegate = self
        mkMapView.delegate = self
        locManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locManager.requestWhenInUseAuthorization()
        locManager.distanceFilter = 10
        // 位置情報の使用の許可を得る
        locManager.requestWhenInUseAuthorization()
        // 縮尺を設定
        var region:MKCoordinateRegion = mkMapView.region
        region.span.latitudeDelta = 0.02
        region.span.longitudeDelta = 0.02
        mkMapView.setRegion(region,animated:true)
        
        // 現在位置表示の有効化
        mkMapView.showsUserLocation = true
        // 現在位置設定（デバイスの動きとしてこの時の一回だけ中心位置が現在位置で更新される）
        mkMapView.userTrackingMode = .follow
        
        // トラッキングボタン表示
        let trakingButton = MKUserTrackingButton(mapView: mkMapView)
        trakingButton.layer.backgroundColor = UIColor(white: 1, alpha: 0.7).cgColor
        
        let dispSize: CGSize = UIScreen.main.bounds.size
        let height = Int(dispSize.height)
        trakingButton.frame = CGRect(x:40, y:height - 82, width:40, height:40)
        
        self.view.addSubview(trakingButton)
        
        // スケールバーの表示
        let scale = MKScaleView(mapView: mkMapView)
        scale.frame.origin.x = 15
        scale.frame.origin.y = 120
        scale.legendAlignment = .trailing
        scale.scaleVisibility = .visible
        self.view.addSubview(scale)
        
        // コンパスの表示
        let compass = MKCompassButton(mapView: mkMapView)
        let width = Int(dispSize.width)
        compass.compassVisibility = .adaptive
        compass.frame = CGRect(x: width - 50, y: 120, width: 40, height: 40)
        self.view.addSubview(compass)
        // デフォルトのコンパスを非表示にする
        mkMapView.showsCompass = false
        
    }
    
    private func addAnnotation() {
        
        removeArray()
        
        if shopCount == 0 {
            return
            
        }
        
        for i in 0...shopCount - 1 {
            
            pointAno = MKPointAnnotation()
            pointAno.coordinate = CLLocationCoordinate2DMake(CLLocationDegrees(shopData[i].lat) , CLLocationDegrees(shopData[i].lng) )
            
            pointAno.title = shopData[i].name
            pointAno.subtitle = shopData[i].open
            nameStringArray.append(shopData[i].name)
            addressStringArray.append(shopData[i].address)
            shopImageStringArray.append(shopData[i].photo.pc.l)
            accessStringArray.append(shopData[i].access)
            parkingStringArray.append(shopData[i].parking)
            openStringArray.append(shopData[i].open)
            catchStringArray.append(shopData[i].catch)
            
            mkMapView.addAnnotation(pointAno)
            
        }
    }
    
    private func removeArray() {
        
        mkMapView.removeAnnotations(mkMapView.annotations)
        
        nameStringArray = []
        addressStringArray = []
        shopImageStringArray = []
        accessStringArray = []
        parkingStringArray = []
        openStringArray = []
        catchStringArray = []
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        self.view.endEditing(true)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        
        return .darkContent
    }
}

// MARK: - SearchShopViewController: CLLocationManagerDelegate, MKMapViewDelegate
extension SearchShopViewController: CLLocationManagerDelegate, MKMapViewDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations:[CLLocation]) {
        let longitude = (locations.last?.coordinate.longitude)!
        let latitude = (locations.last?.coordinate.latitude)!
        
        let lngFloor = ceil(longitude * 1000)/1000
        let latFloor = floor(latitude * 100)/100
        
        latValue = latFloor
        lngValue = lngFloor
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        indexNumber = Int()
        
        if nameStringArray.firstIndex(of: (view.annotation?.title)!!) != nil {
            
            indexNumber = nameStringArray.firstIndex(of: (view.annotation?.title)!!)!
        }
        
        let shopDetailViewController = UIStoryboard(name: "ShopDetail", bundle: nil).instantiateViewController(withIdentifier: "ShopDetailViewController") as! ShopDetailViewController
        
        shopDetailViewController.modalPresentationStyle = .fullScreen
        shopDetailViewController.shopDetail = self.shopData[indexNumber]
        self.present(shopDetailViewController, animated: true, completion: nil)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        let status = manager.authorizationStatus
        switch status {
        case .authorizedAlways, .authorizedWhenInUse: locManager.startUpdatingLocation()
            break
            
        case .notDetermined, .denied, .restricted:
            break
            
        default:
            break
            
        }
        
        switch manager.accuracyAuthorization {
        case .reducedAccuracy: break
        case .fullAccuracy: break
            
        default:
            print("This should not happen")
        }
    }
}
