//
//  ViewController.swift
//  MKmapkit
//
//  Created by Dan Li on 03.10.19.
//  Copyright © 2019 Dan Li. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate//CLLocationManagerDelegate跟踪使用者位置
{
    
    var locationManager:CLLocationManager?//设定一个得知用户位置的属性
    @IBOutlet weak var mapview: MKMapView!
    
    //屏幕长按并加入annotation
    @IBAction func addMeAnnotation(_ sender: UILongPressGestureRecognizer)
    {
    let touchPoint = sender.location(in: mapview)
    let touchCoordinate: CLLocationCoordinate2D = mapview.convert(touchPoint, toCoordinateFrom: mapview)
    let annotation = MKPointAnnotation()
    annotation.coordinate = touchCoordinate//touchCoordinate是用户随机在画iPhone屏幕上的按出的地标。
    annotation.title = "New Event"
    annotation.subtitle = "Datum: 20.10.2020-29.10.2020"
    mapview.addAnnotation(annotation)
    }
 
    //随时返回用户地点
    @IBAction func centerTapped(_ sender: UIButton)
    {
        if let center = locationManager?.location?.coordinate
        {
            let region = MKCoordinateRegion(center: center, latitudinalMeters: 200, longitudinalMeters: 200)
            mapview.setRegion(region, animated: false)
        }
    }
    
    //地图显示类型转换按钮
    var artOfMapFlag = true
    @IBAction func art_Of_View(_ sender: UIButton)
    {
        if(artOfMapFlag==true)
        {
            mapview.mapType = .hybridFlyover
            artOfMapFlag=false
        }
        else
        {
            mapview.mapType = .standard
            artOfMapFlag=true
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        locationManager = CLLocationManager()//得知用户位置方法
        locationManager?.requestWhenInUseAuthorization()//使用者位置授权
        locationManager?.delegate=self//上面服从了CLLocationManagerDelegate为了能够设定跟踪使用者位置
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest//设定跟踪位置准确程度
        locationManager?.activityType = .automotiveNavigation//设定行动活动模式//.后面还有4种其他模式例如步行模式，运动模式等。
        locationManager?.startUpdatingLocation()//每次手机地点变更就触发协定方法//协定func在下边写出
            
        if let coordinate = locationManager?.location?.coordinate//使用者目前坐标
        {
            let span:MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: xScale, longitudeDelta: yScala)
            let region = MKCoordinateRegion(center: coordinate, span: span)
            mapview.setRegion(region, animated: false)
        }
        //mapview.userTrackingMode = .followWithHeading//根据使用者转变方向
    //地图 区域显示
      //  mapsetRegio(latitudi: latititude, longitudi: logitutde, xscala: xScale, yscala: yScala)
    //显示annotation
        //annotationView(latitudi: latititude, longitudi: logitutde, xscala: xScale, yscala: yScala)
    }
    
    //每次手机地点变更就触发此协定方法//对应上边的调用协议（locationManager?.startUpdatingLocation()//每次手机地点变更就触发协定方法//协定func在下边写出）；
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        print("________________________________")
        print(locations[0].coordinate.latitude)//拿到最新的位置坐标
        print(locations[0].coordinate.longitude)
        
    }
       
    /*地图显示区域设定*/
        let latititude:CLLocationDegrees = 48.858547
        let logitutde:CLLocationDegrees = 2.294524
    /*设定放大缩小比例*/
        let xScale:CLLocationDegrees = 0.01
        let yScala:CLLocationDegrees = 0.01
    
    //显示地图位置
    func mapsetRegio(latitudi:Double, longitudi:Double, xscala:Double, yscala:Double)
    {
        let location:CLLocationCoordinate2D=CLLocationCoordinate2D(latitude: latitudi, longitude: longitudi)
        let span:MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: xscala, longitudeDelta: yscala)
        let region : MKCoordinateRegion = MKCoordinateRegion(center: location, span: span)
        mapview.setRegion(region, animated: false)
    }
    
    /*大头针根据固定 let latititude 和 let yScala 地址显示大头针的位置*/
    func annotationView(latitudi:Double, longitudi:Double, xscala:Double, yscala:Double)
    {
        let location:CLLocationCoordinate2D=CLLocationCoordinate2D(latitude: latitudi, longitude: longitudi)
        let annotation = MKPointAnnotation()
        annotation.title = "Veranstaltungen"
        annotation.subtitle = "18.102010-26.10.2010"
        annotation.coordinate = location
        
        mapview.addAnnotation(annotation)
    }
    
    //在用户推出本app时关闭追踪，省电。
    override func viewDidDisappear(_ animated: Bool)
    {
        locationManager?.startUpdatingLocation()
    }
}

