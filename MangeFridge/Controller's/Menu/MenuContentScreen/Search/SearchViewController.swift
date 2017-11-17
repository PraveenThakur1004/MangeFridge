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
   
    var ingredentSelectPoper = SHMultipleSelect()
    var filetrerSelectPoper  = SHMultipleSelect()
    var selectedString:String?
    var isFilter = false
    var filterArray = ["Drink","Food","Top Rated","Favourite"]
    var selectionArray = ["Ingredent1","Ingredent2","Ingredent3","Ingredent4","Ingredent5","Ingredent6"]
    @IBOutlet weak var view_Filter: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nsLayout_heightOfView.constant = 0
        self.nslayOut_ButtonHeight.constant = 0
        self.nslayout_lblFilterHeight.constant = 0
        self.view.layoutIfNeeded()
       decorateSegmentedControl()
        // Do any additional setup after loading the view.
    }
    @IBAction func segmentChanged(_ sender: CustomSegment) {
        print(sender.selectedIndex)
     
        if sender.selectedIndex == 0{
            UIView.animate(withDuration: 0.30, animations: {
                self.nsLayout_heightOfView.constant = 0
                self.nslayOut_ButtonHeight.constant = 0
                self.nslayout_lblFilterHeight.constant = 0
                self.view.layoutIfNeeded()
            }, completion: nil)
           
            } else {
            UIView.animate(withDuration: 0.30, animations: {
                self.nslayOut_ButtonHeight.constant = 44
                self.nslayout_lblFilterHeight.constant = 17
                self.nsLayout_heightOfView.constant = 55
                self.view.layoutIfNeeded()
            }, completion: nil)
           
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //Hide NavigationBar
        selectedString = "Select Ingredents"
        lbl_Ingredents.text = selectedString
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        
    }
    
    @IBAction func action_DropDown(_ sender: UIButton) {
       if sender.tag == 101{
            isFilter = true
            filetrerSelectPoper.delegate = self
            filetrerSelectPoper.rowsCount = filterArray.count
            filetrerSelectPoper.show()
        }else{
            isFilter = false
          ingredentSelectPoper.delegate = self
          ingredentSelectPoper.rowsCount = selectionArray.count
          ingredentSelectPoper.show()
        }
       
    }
    //Navigation back button action
    @IBAction func openMenu(_ sender: UIButton) {
      showSideMenu()
    }
    //MARK:- Segment control
    func decorateSegmentedControl(){
        segmentSearch.selectedIndex = 0
        self.segmentChanged(self.segmentSearch)
    }
    
}
extension SearchViewController : SHMultipleSelectDelegate{
    
    func multipleSelectView(_ multipleSelectView: SHMultipleSelect!, clickedBtnAt clickedBtnIndex: Int, withSelectedIndexPaths selectedIndexPaths: [Any]!) {
        
        if selectedIndexPaths != nil {
            let indexer : [IndexPath] = selectedIndexPaths as! [IndexPath]
            if clickedBtnIndex == 1 {
                // Done btn
                let itemArray = NSMutableArray()
                for indexPath: IndexPath in indexer {
                    print("\(selectionArray[indexPath.row])")
                    if isFilter == true{
                         itemArray.insert(filterArray[indexPath.row], at: 0)
                    }
                    else{
                         itemArray.insert(selectionArray[indexPath.row], at: 0)
                    }
                  }
                selectedString =  (itemArray.map{String(describing: $0)}).joined(separator: ",")
                if isFilter == true{
                    lbl_Filter.text = selectedString
                }else{
                    lbl_Ingredents.text = selectedString
                    
                }
            }
        }

    }
    func multipleSelectView(_ multipleSelectView: SHMultipleSelect!, titleForRowAt indexPath: IndexPath!) -> String! {
        if isFilter == true{
            return self.filterArray[indexPath.row]
        }else{
        return self.selectionArray[indexPath.row]
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


