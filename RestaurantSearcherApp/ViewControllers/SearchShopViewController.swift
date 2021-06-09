//
//  ViewController.swift
//  RestaurantSercherApp
//
//  Created by 大谷空 on 2021/06/02.
//

import UIKit
import MapKit
import Alamofire


class SearchShopViewController: UIViewController {
    
    private var shopData = [Shop]()
    private var shopCount = Int()
    var idoValue = Double()
    var keidoValue = Double()
    private var locManager: CLLocationManager!
    private var pointAno: MKPointAnnotation = MKPointAnnotation()
    
    @IBOutlet weak var searchWordTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var mkMapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupMap()
        searchButton.addTarget(self, action: #selector(tappedSearchButton), for: .touchUpInside)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        fetchShopDataInfo()
    }
    
    @objc private func tappedSearchButton() {
        
        let searchText = searchWordTextField.text ?? ""
        
        fetchSearchShopInfo(searchText: searchText)
        searchWordTextField.resignFirstResponder()
    }
    
    private func fetchShopDataInfo() {
        
        let params = [
            "lat": "\(idoValue)",
            "lng": "\(keidoValue)"
            
        ] as [String : Any]
        
        API.shared.request(params: params, type: ShopData.self) { (shop) in
            
            self.shopData = shop.results.shop
            self.shopCount = shop.results.shop.count
            print("shopCount: ", self.shopCount)
            self.addAnnotation()
        }
    }
    
    private func fetchSearchShopInfo(searchText: String) {
        
        let params = [
            
            "keyword": searchText,
            "lat": "\(idoValue)",
            "lng": "\(keidoValue)"
            
        ] as [String : Any]
        
        API.shared.request(params: params, type: ShopData.self) { (shop) in
            
            self.shopData = shop.results.shop
            self.shopCount = shop.results.shop.count
            print("shopCount: ", self.shopCount)
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
        
        mkMapView.removeAnnotations(mkMapView.annotations)
        
        if shopCount == 0 {
            return
            
        }
        
        for i in 0...shopCount - 1 {
            
            print(i)
            pointAno = MKPointAnnotation()
            pointAno.coordinate = CLLocationCoordinate2DMake(CLLocationDegrees(shopData[i].lat) , CLLocationDegrees(shopData[i].lng) )
            
            pointAno.title = shopData[i].name
            pointAno.subtitle = shopData[i].open
            mkMapView.addAnnotation(pointAno)
            
        }
    }
}

extension SearchShopViewController: CLLocationManagerDelegate, MKMapViewDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations:[CLLocation]) {
        let longitudeString = (locations.last?.coordinate.longitude)!
        let latitudeString = (locations.last?.coordinate.latitude)!
        
        let lngFloor = ceil(longitudeString * 1000)/1000
        let latFloor = floor(latitudeString * 100)/100
        
        idoValue = latFloor
        keidoValue = lngFloor
        
        print("lon : ", keidoValue)
        print("lat : ", idoValue)
        
        // 現在位置とタップした位置の距離(m)を算出する
        let distance = calcDistance(mkMapView.userLocation.coordinate, pointAno.coordinate)
        
        if (0 != distance) {
            // ピンに設定する文字列を生成する
            var string:String = Int(distance).description
            string = string + " m"
            
            // yard
            let yardString = Int(distance * 1.09361)
            string = string + " / " + yardString.description + " yard"
            
        }
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
    
    // 2点間の距離(m)を算出する
    func calcDistance(_ a: CLLocationCoordinate2D, _ b: CLLocationCoordinate2D) -> CLLocationDistance {
        // CLLocationオブジェクトを生成
        let aLoc: CLLocation = CLLocation(latitude: a.latitude, longitude: a.longitude)
        let bLoc: CLLocation = CLLocation(latitude: b.latitude, longitude: b.longitude)
        // CLLocationオブジェクトのdistanceで2点間の距離(m)を算出
        let dist = bLoc.distance(from: aLoc)
        return dist
    }
}
