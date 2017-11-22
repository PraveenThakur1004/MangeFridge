//
//  SearchViewController.swift
//  MangeFridge
//
//  Created by MAC on 05/11/17.
//  Copyright © 2017 Orem. All rights reserved.
//

import UIKit
import  InteractiveSideMenu
import TransitionButton
import SHMultipleSelect
import FTIndicator
class SearchViewController: CustomTransitionViewController,SideMenuItemContent {
    //MARK- IBoutlet and constants
    //LayoutConstants
    @IBOutlet weak var nslayout_lblFilterHeight: NSLayoutConstraint!
    @IBOutlet weak var nslayOut_ButtonHeight: NSLayoutConstraint!
    @IBOutlet weak var layout_SearchTop: NSLayoutConstraint!
    @IBOutlet weak var nsLayout_heightOfView: NSLayoutConstraint!
    //other
    @IBOutlet weak var lbl_Ingredents: UILabel!
    @IBOutlet weak var txtFld_Other: UITextField!
    @IBOutlet weak var lbl_Filter: UILabel!
    @IBOutlet weak var txt_FieldOther: UITextField!
    @IBOutlet weak var segmentSearch: CustomSegment!
    @IBOutlet weak var view_Filter: UIView!
    var ingredentSelectPoper = SHMultipleSelect()
    var filetrerSelectPoper  = SHMultipleSelect()
    var selectedString:String?
    var selectedfilterSting:String?
    var selectedfiltersID:String?
    var selectedIngredientsID:String?
    var isFilter = false
    var filterArray = [Ingredients]()
    var searchResultArray = [Item]()
    var selectionArray = [Ingredients]()
    var selectedIngredients = [Ingredients]()
    var selectedFilters = [Ingredients]()
    var wsManager = WebserviceManager()
   
    //MARK:- ViewLifeCylcle
    override func viewDidLoad() {
        super.viewDidLoad()
        //Set Multipart tintColor
        ingredentSelectPoper.tintColor = UIColor(red : 134/255 , green : 197 / 255  , blue : 86 / 255 , alpha : 1.0)
        filetrerSelectPoper.tintColor = UIColor(red : 134/255 , green : 197 / 255  , blue : 86 / 255 , alpha : 1.0)
        //Set up layout for ingredients only
        self.nsLayout_heightOfView.constant = 0
        self.nslayOut_ButtonHeight.constant = 0
        self.nslayout_lblFilterHeight.constant = 0
        self.view.layoutIfNeeded()
        decorateSegmentedControl()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //Hide NavigationBar
        selectedString = "Select Ingredents"
        selectedIngredientsID = ""
        selectedfiltersID = ""
        selectedfilterSting = "Select Filters"
        lbl_Ingredents.text = selectedString
        lbl_Filter.text = selectedfilterSting
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        
    }
    //MARK:- IBAction
    //Segment button actions
    @IBAction func segmentChanged(_ sender: CustomSegment) {
        print(sender.selectedIndex)
        if sender.selectedIndex == 0{
            //Ingredients only
            selectedfiltersID = ""
            selectedfilterSting = "Select Filters"
            lbl_Filter.text = selectedfilterSting
            UIView.animate(withDuration: 0.30, animations: {
                self.nsLayout_heightOfView.constant = 0
                self.nslayOut_ButtonHeight.constant = 0
                self.nslayout_lblFilterHeight.constant = 0
                self.view.layoutIfNeeded()
            }, completion: nil)
            
        } else {
            //show ingredents and filter
            UIView.animate(withDuration: 0.30, animations: {
                self.nslayOut_ButtonHeight.constant = 44
                self.nslayout_lblFilterHeight.constant = 17
                self.nsLayout_heightOfView.constant = 55
                self.view.layoutIfNeeded()
            }, completion: nil)
            
        }
    }
    //DropDown for filter and ingredients actions
    @IBAction func action_DropDown(_ sender: UIButton) {
        if sender.tag == 101{
            isFilter = true
            filetrerSelectPoper.delegate = self
            if Singleton.sharedInstance.filters == nil{
                FTIndicator.showProgress(withMessage: "Loading..")
                wsManager.getFilters{ (sucess, filters) in
                    FTIndicator.dismissProgress()
                    if sucess{
                        Singleton.sharedInstance.filters = filters
                        self.filterArray = filters
                        self.filetrerSelectPoper.rowsCount = self.filterArray.count
                        self.filetrerSelectPoper.show()
                        
                    }else{
                        FTIndicator.showError(withMessage: "Somting went wrong")
                    }
                }
            }else{
                filterArray =    Singleton.sharedInstance.filters
                filetrerSelectPoper.rowsCount = filterArray.count
                filetrerSelectPoper.show()
            }
        }else{
            isFilter = false
            ingredentSelectPoper.delegate = self
            if Singleton.sharedInstance.ingredients == nil{
                FTIndicator.showProgress(withMessage: "Loading..")
                wsManager.getIngredients { (sucess, ingredients) in
                    FTIndicator.dismissProgress()
                    if sucess{
                        Singleton.sharedInstance.ingredients = ingredients
                        self.selectionArray = ingredients
                        self.ingredentSelectPoper.rowsCount = self.selectionArray.count
                        self.ingredentSelectPoper.show()
                        
                    }else{
                        FTIndicator.showError(withMessage: "Somting went wrong")
                    }
                }
            }else{
                selectionArray =    Singleton.sharedInstance.ingredients
                ingredentSelectPoper.rowsCount = selectionArray.count
                ingredentSelectPoper.show()
            }
            
        }
        
    }
    //Navigation back button action
    @IBAction func openMenu(_ sender: UIButton) {
        showSideMenu()
    }
    //Search Actions
    @IBAction func action_Search(_ button: TransitionButton) {
        if (lbl_Ingredents.text?.isEmpty)! {
            FTIndicator.showError(withMessage: "Please Enter Ingredents")
            return
        }
        else{
            if(lbl_Ingredents.text == "Select Ingredents"){
                FTIndicator.showError(withMessage:"Please Enter Ingredents")
                return
            }
        }
        button.startAnimation()
        var parameters:NSDictionary = ["ingredient":selectedIngredientsID ?? "","filter":selectedfiltersID ?? ""]
        if Singleton.sharedInstance.guestUser == false{
            if let id = Singleton.sharedInstance.user.id{
                parameters = ["ingredient":selectedIngredientsID ?? "","user_id":id,"filter":selectedfiltersID ?? ""  ]
            }
            else{
                FTIndicator.showError(withMessage: "User not exist")
                return
            }
            
        }
        wsManager.searchIngredents(parameters:parameters ) { (sucess, items, message) in
            if sucess{
                if (items.isEmpty){
                    button.stopAnimation(animationStyle: .shake, completion: {
                        FTIndicator.showError(withMessage: message)
                    })}
                else{
                    button.stopAnimation(animationStyle: .expand, completion: {
                        self.searchResultArray = items
                        self.performSegue(withIdentifier: "searchResult", sender: self)
                        
                    })
                }
                
            }
            else{
                button.stopAnimation(animationStyle: .shake, completion: {
                    FTIndicator.showError(withMessage: message)
                })
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "searchResult" {
            let vc = segue.destination as! SearchResultViewController
            vc.searchResultArray = searchResultArray
            vc.selectedIngredientsArray = selectedIngredients
            vc.selectedfiltersID = selectedfiltersID! as NSString
        }
    }
    //MARK:- Segment control
    func decorateSegmentedControl(){
        segmentSearch.selectedIndex = 0
        self.segmentChanged(self.segmentSearch)
    }
    
}
//MARK:- Extension Delegates
//Multiple Selection delegare
extension SearchViewController : SHMultipleSelectDelegate{
    func multipleSelectView(_ multipleSelectView: SHMultipleSelect!, clickedBtnAt clickedBtnIndex: Int, withSelectedIndexPaths selectedIndexPaths: [Any]!) {
        //if filter selected then delete exting filters selections
        if isFilter == true{
            selectedfilterSting = ""
            selectedfiltersID = ""
            selectedFilters = [Ingredients]()
        }else{
            //if Ingredients selected then delete exting ingredients selections
            selectedString = ""
            selectedIngredients = [Ingredients]()
            selectedIngredientsID = ""
            }
        if selectedIndexPaths != nil {
            let indexer : [IndexPath] = selectedIndexPaths as! [IndexPath]
            if clickedBtnIndex == 1 {
                // Done btn
                for indexPath: IndexPath in indexer {
                  if isFilter == true{
                          //Add the selected filter values to arrays
                        selectedFilters.insert(filterArray[indexPath.row], at: 0)
                    }
                    else{
                       //Add the selected ingrident values to arrays
                        selectedIngredients.insert(selectionArray[indexPath.row], at: 0)
                    }
                }
                 //Get selected items name and id's in comma seprated form to show in label and pass in api's
                if isFilter == true{
                   for value in selectedFilters{
                        let name = value.name
                        let id = value.id
                        if selectedfilterSting != ""{
                            selectedfilterSting = selectedfilterSting! + ",\(name)"
                            selectedfiltersID = selectedfiltersID! + ",\(id)"}else{
                            selectedfilterSting = name
                            selectedfiltersID = id
                            
                        }
                    }
                    
                }else{
                    for value in selectedIngredients{
                        let name = value.name
                        let id = value.id
                        if selectedString != ""{
                            selectedString = selectedString! + ",\(name)"
                            selectedIngredientsID = selectedIngredientsID! + ",\(id)"}else{
                            selectedString = name
                            selectedIngredientsID = id
                        }
                    }
                }
                if isFilter == true{
                    lbl_Filter.text = selectedfilterSting
                }else{
                    lbl_Ingredents.text = selectedString
                }
            }
        }else{
            if isFilter == true{
                lbl_Filter.text = "Select Filters"
            }else{
                lbl_Ingredents.text = "Select Ingredents"
            }
        }
        
    }
    func multipleSelectView(_ multipleSelectView: SHMultipleSelect!, titleForRowAt indexPath: IndexPath!) -> String! {
        if isFilter == true{
            let ingerdient = self.filterArray[indexPath.row]
            return ingerdient.name
        }else{
            let ingerdient = self.selectionArray[indexPath.row]
            return ingerdient.name
        }
    }
    func multipleSelectView(_ multipleSelectView: SHMultipleSelect!, setSelectedForRowAt indexPath: IndexPath!) -> Bool {
        var canSelect = false
        if isFilter == true{
            if indexPath.row == filterArray.count {
                canSelect = true
            }
            return canSelect
            }
        else{
            if indexPath.row == selectionArray.count {
                canSelect = true
            }
            return canSelect
        }
        
    }
}
//MARK:- textField Delegates
extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder();
        return true
    }
}


