//
//  ViewController.swift
//  RestaurantSercherApp
//
//  Created by 大谷空 on 2021/06/02.
//

import UIKit
import MapKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {
    
    @IBOutlet weak var searchWordTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var mkMapView: MKMapView!
    @IBOutlet var longPressGesRec: UILongPressGestureRecognizer!
    
    private var shopData = [Shop]()
    private var locManager: CLLocationManager!
    private var routePolyLine: MKPolyline!
    private var pointAno: MKPointAnnotation = MKPointAnnotation()
    var idoValue = String()
    var keidoValue = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchShopDataInfo()
        setupMap()
        
        searchButton.addTarget(self, action: #selector(tappedSearchButton), for: .touchUpInside)
    }
    
    @objc private func tappedSearchButton() {
        
        searchWordTextField.resignFirstResponder()
        
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
        
        // MapViewにピンを立てる
        mkMapView.addAnnotation(pointAno)
        mkMapView.removeAnnotation(pointAno)
        
        
    }
    
    @IBAction func mapViewDidLongPress(_ sender: UILongPressGestureRecognizer) {
        
        // ロングタップ開始
        if sender.state == .began {
            mkMapView.removeAnnotation(pointAno)
            
        }
        // ロングタップ終了（手を離した）
        else if sender.state == .ended {
            // タップした位置（CGPoint）を指定してMkMapView上の緯度経度を取得する
            let tapPoint = sender.location(in: view)
            let center = mkMapView.convert(tapPoint, toCoordinateFrom: mkMapView)
            
            let lonStr = center.longitude.description
            let latStr = center.latitude.description
            print("lon : " + lonStr)
            print("lat : " + latStr)
            
            // 現在位置とタップした位置の距離(m)を算出する
            let distance = calcDistance(mkMapView.userLocation.coordinate, center)
            print("distance : " + distance.description)
            
            // ピンに設定する文字列を生成する
            var str:String = Int(distance).description
            str = str + " m"
            
            // yard
            let yardStr = Int(distance * 1.09361)
            str = str + " / " + yardStr.description + " yard"
            
            if pointAno.title != str {
                // ピンまでの距離に変化があればtiteを更新する
                pointAno.title = str
                mkMapView.addAnnotation(pointAno)
            }
            
            // ロングタップを検出した位置にピンを立てる
            pointAno.coordinate = center
            mkMapView.addAnnotation(pointAno)
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
    
    private func fetchShopDataInfo() {
        
        let params = ["keyword": "餃子の王将"]
        
        API.shared.request(params: params, idoValue: idoValue, keidoValue: keidoValue, type: ShopData.self) { (shop) in
            
            self.shopData = shop.results.shop
        }
        
    }
}

extension ViewController: CLLocationManagerDelegate, MKMapViewDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations:[CLLocation]) {
        let longitudeString = (locations.last?.coordinate.longitude.description)!
        let latitudeString = (locations.last?.coordinate.latitude.description)!
        
        idoValue = latitudeString
        keidoValue = longitudeString
        
        print("lon : " + longitudeString)
        print("lat : " + latitudeString)
        
        // 現在位置とタッウプした位置の距離(m)を算出する
        let distance = calcDistance(mkMapView.userLocation.coordinate, pointAno.coordinate)
        
        if (0 != distance) {
            // ピンに設定する文字列を生成する
            var string:String = Int(distance).description
            string = string + " m"
            
            // yard
            let yardString = Int(distance * 1.09361)
            string = string + " / " + yardString.description + " yard"
            
            if pointAno.title != string {
                // ピンまでの距離に変化があればtitleを更新する
                pointAno.title = string
                mkMapView.addAnnotation(pointAno)
            }
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
    
    func updateCurrentPos(_ coordinate:CLLocationCoordinate2D) {
        var region:MKCoordinateRegion = mkMapView.region
        region.center = coordinate
        mkMapView.setRegion(region,animated:true)
    }
}
