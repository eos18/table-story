//
//  ViewController.swift
//  TableStory
//
//  Created by English, Kate on 3/17/25.
//

import UIKit
import MapKit

//array objects of our data.
let data = [
    Item(name: "Emma", neighborhood: "Jane Austen", desc: "Emma by Jane Austen follows Emma Woodhouse, a wealthy and self-assured young woman living in Highbury, England who takes pride in her matchmaking skills. However, her well-intended meddling often leads to misunderstandings and unexpected consequences. Through her experiences, she matures, realizing her own feelings and learning valuable lessons about love, humility, and self-awareness.", lat: 51.5457996, long: -0.1027127, imageName: "emma"),
    Item(name: "Fahrenheit 451", neighborhood: "Ray Bradbury", desc: "Fahrenheit 451 by Ray Bradbury is set in a dystopian future where books are banned, and 'firemen' burn any that are found. The story follows Guy Montag, a fireman who begins questioning his role in a society that suppresses free thought and individuality. As Montag embarks on a journey of self-discovery, he rebels against the oppressive regime and seeks knowledge through forbidden books.", lat: 41.881832, long: -87.623177, imageName: "fh"),
    Item(name: "Fried Green Tomatoes", neighborhood: "Fannie Flagg", desc: "Fried Green Tomatoes at the Whistle Stop Cafe by Fannie Flagg follows the lives of Ruth Jamison and Idgie Threadgoode, two women who run a café in the small town of Whistle Stop, Alabama. The novel intertwines their story with the present-day life of Evelyn Couch, a middle-aged woman living in Birmingham, Alabama who befriends Ninny Threadgoode in a nursing home.", lat: 33.543682, long: -86.779633, imageName: "fgt"),
    Item(name: "A Tale of Two Cities", neighborhood: "Charles Dickens", desc: "A Tale of Two Cities by Charles Dickens is set during the French Revolution and contrasts the lives of people in Paris and London. It follows the story of Charles Darnay, a French aristocrat who renounces his family’s wealth, and Sydney Carton, a disillusioned English lawyer, who both find their fates intertwined in the turbulent political climate.", lat: 48.8575, long: 2.3514, imageName: "atotc"),
    Item(name: "Flowers in the Attic", neighborhood: "V.C. Andrews", desc: "Flowers in the Attic by V.C. Andrews is set in Charlottesville, Virginia and tells the dark tale of the Dollanganger children, who are locked away in an attic by their mother and grandfather after their father's death. The children endure severe abuse and neglect while struggling to survive in isolation, with their bond growing stronger as they face their harrowing circumstances.", lat: 38.033554, long: -78.507980, imageName: "flowers")
   
]

struct Item {
    var name: String
    var neighborhood: String
    var desc: String
    var lat: Double
    var long: Double
    var imageName: String
}




class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var theTable: UITableView!
    
    
    @IBOutlet weak var mapView: MKMapView!
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return data.count
   }


   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell")
       let item = data[indexPath.row]
       cell?.textLabel?.text = item.name
       
       //Add image references
                     let image = UIImage(named: item.imageName)
                     cell?.imageView?.image = image
                     cell?.imageView?.layer.cornerRadius = 10
                     cell?.imageView?.layer.borderWidth = 5
                     cell?.imageView?.layer.borderColor = UIColor.white.cgColor
       
       return cell!
   }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = data[indexPath.row]
        performSegue(withIdentifier: "ShowDetailSegue", sender: item)
      
    }
    
    // add this function to original ViewController
            override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
              if segue.identifier == "ShowDetailSegue" {
                  if let selectedItem = sender as? Item, let detailViewController = segue.destination as? DetailViewController {
                      // Pass the selected item to the detail view controller
                      detailViewController.item = selectedItem
                  }
              }
          }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        theTable.delegate = self
        theTable.dataSource = self
        
        
        //add this code in viewDidLoad function in the original ViewController, below the self statements

           //set center, zoom level and region of the map
        let coordinate = CLLocationCoordinate2D(latitude: 36.031332, longitude: -35.156250)
               let region = MKCoordinateRegion(center: coordinate,span: MKCoordinateSpan(latitudeDelta: 100, longitudeDelta: 100))
        
        
               mapView.setRegion(region, animated: true)
               
            // loop through the items in the dataset and place them on the map
                for item in data {
                   let annotation = MKPointAnnotation()
                   let eachCoordinate = CLLocationCoordinate2D(latitude: item.lat, longitude: item.long)
                   annotation.coordinate = eachCoordinate
                       annotation.title = item.name
                       mapView.addAnnotation(annotation)
                       }
        
        
    }


}

