//Does not do anything, just a example of DOFavoriteButton

import UIKit

class Berryessa: UIViewController {
    
    var button = DOFavoriteButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        button = DOFavoriteButton(frame: CGRect(x: UIScreen.main.bounds.width - 50, y: 65, width: 50, height: 50), image: UIImage(named: "stars.png"))
        self.view.addSubview(button)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let defaults = UserDefaults.standard
        
        if (defaults.string(forKey: "Favorite") == "Berryessa"){
            if (button.isSelected == false){
                button.select()
            }
        }else{
            button.deselect()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
