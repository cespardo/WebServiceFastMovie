//
//  ViewController.swift
//  WebServiceFastMovie
//
//  Created by César Jesús Pardo Calvache on 15/04/15.
//  Copyright (c) 2015 Frejya Soft. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //Labels donde voy a imprimir la información que me devuelve el webservice y que voy a imprimir en pantalla
    @IBOutlet weak var labelNameMovie: UILabel!
    @IBOutlet weak var labelYearMovie: UILabel!
    @IBOutlet weak var labelReleasedMovie: UILabel!
    @IBOutlet weak var labelGenreMovie: UILabel!
    @IBOutlet weak var labelDirectorMovie: UILabel!
    @IBOutlet weak var labelLanguageMovie: UILabel!
    @IBOutlet weak var labelAwardsMovie: UILabel!
    @IBOutlet weak var labelImdbRatingMovie: UILabel!
    
    
    //Este es el UITextField que captura el nombre de la película
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
          // self.view.backgroundColor = UIColor(patternImage: UIImage(named: "cinema.jpg")!)
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBOutlet weak var getNameMovie: UITextField!
    //Este método hace el llamado del objeto JSON a partir de lo que digita y captura del UITextField
    @IBAction func initiateWebServiceCall(sender: UIButton) {
        
        
        //println("Information Movie: \(getNameMovie.text)")
        //Método que va a parsear el objeto JSON a texto.
        llamadaWebService()
        
    }
    
    func llamadaWebService(){
        
        let urlPath = "http://www.omdbapi.com/?t=\(getNameMovie.text)"
        
        //let urlPath = "http://www.omdbapi.com/?t=frozen&y=&plot=short&r=json"

        let url = NSURL(string: urlPath)
        
        let session = NSURLSession.sharedSession()

        
        let task = session.dataTaskWithURL(url!, completionHandler: {data, response, error -> Void in
        
            if(error != nil){
                //Imprimir descripción del error
                println(error.localizedDescription)
            }
            //Si no hubo un error, lo que que devuelve la petición lo pongo en nsdata, estos datos no son legibles, los debemos transformar
            var nsdata:NSData = NSData(data:data)
            //println(nsdata)
            
            self.recuperarPeliculaDeJson(nsdata)
            
        
        })
        
        task.resume()
        
    }
    
    func recuperarPeliculaDeJson(nsdata:NSData){
        
        let jsonCompleto : AnyObject! = NSJSONSerialization.JSONObjectWithData(nsdata, options: NSJSONReadingOptions.MutableContainers, error: nil)
        //println(jsonCompleto)
        
        //Tranformo la información del objeto JSON a NSString
        let title: String! = jsonCompleto["Title"] as NSString
        let year: String! = jsonCompleto["Year"] as NSString
        let released: String! = jsonCompleto["Released"] as NSString
        let genre: String! = jsonCompleto["Genre"] as NSString
        let director: String! = jsonCompleto["Director"] as NSString
        let language: String! = jsonCompleto["Language"] as NSString
        let awards: String! = jsonCompleto["Awards"] as NSString
        let imdbRating: String! = jsonCompleto["imdbRating"] as NSString
        
        //println(title)
        //println(year)
        
        //Imprimo en los labels
        self.labelNameMovie.text = title
        self.labelYearMovie.text = year
        self.labelReleasedMovie.text = released
        self.labelGenreMovie.text = genre
        self.labelDirectorMovie.text = director
        self.labelLanguageMovie.text = language
        self.labelAwardsMovie.text = awards
        self.labelImdbRatingMovie.text = imdbRating
        
    }
}

