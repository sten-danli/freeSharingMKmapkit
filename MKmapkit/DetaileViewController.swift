//
//  DetaileViewController.swift
//  MKmapkit
//
//  Created by Dan Li on 03.10.19.
//  Copyright © 2019 Dan Li. All rights reserved.
//



import UIKit

protocol DtaileViewControllerDelegate
{
    func SecondVctoFirstVc(UITextField:String)
    
}


class DetaileViewController: UIViewController
{
     var delegate : DtaileViewControllerDelegate?
    
    @IBOutlet weak var _title_Field: UITextField!
    

    @IBOutlet weak var _subtitle_TextView: UITextView!
    
    @IBOutlet weak var _title: UILabel!
    @IBOutlet weak var _subtitle: UILabel!
    @IBOutlet weak var _coordinate: UILabel!
    
    var main_title = ""
    var main_subtitle = ""
    var latitud = 0.0
    var longitud = 0.0
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
       
        
        _title.text = main_title
        _title_Field.text = main_title
        
        _subtitle.text = main_subtitle
        _subtitle_TextView.text = main_subtitle
        _coordinate.text = String(format: "Lat: %.6f // Lon: %.6f",latitud,longitud)
        

    }
    @IBAction func savebuttontapped(_ sender: UIBarButtonItem)
    {
         delegate?.SecondVctoFirstVc( UITextField: _title_Field.text!)
        
        navigationController?.popViewController(animated: false)
        
       
        
        
        
        
        
        
        
        
        
        
        
        
        
        if let oktext = _title_Field.text
        {
          if oktext != ""
          {
            if let firstviewcontroller = self.tabBarController?.viewControllers?[0] as? ViewController
            {
            
                firstviewcontroller.newAoontationTitleInfo.title = _title_Field.text
                firstviewcontroller.newAoontationSubtitleInfo.title = _subtitle_TextView.text
             
                
                
            }
          }

        }
    }
}
