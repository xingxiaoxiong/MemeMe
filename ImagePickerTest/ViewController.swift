//
//  ViewController.swift
//  ImagePickerTest
//
//  Created by shapeare on 6/16/15.
//  Copyright (c) 2015 BettyBearStudio. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    
    @IBOutlet weak var shareButton: UIBarButtonItem!
    //@IBOutlet weak var bottomToolbar: UIToolbar!
    var memedImage:UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let memeTextAttributes = [
            NSStrokeColorAttributeName : UIColor.blackColor(),
            NSForegroundColorAttributeName : UIColor.whiteColor(),
            NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSStrokeWidthAttributeName : -2.0
        ]
        
        //topTextField.backgroundColor = UIColor.clearColor()
        topTextField.text = "TOP"
        topTextField.textAlignment = .Center
        topTextField.defaultTextAttributes = memeTextAttributes
        topTextField.delegate = self
        
        //bottomTextField.backgroundColor = UIColor.clearColor()
        bottomTextField.text = "BOTTOM"
        bottomTextField.textAlignment = .Center
        bottomTextField.defaultTextAttributes = memeTextAttributes
        bottomTextField.delegate = self
        
        //imageView.addSubview(topTextField)
        //imageView.addSubview(bottomTextField)
        
        
        shareButton.enabled = false
    }
    
    override func viewWillAppear(animated: Bool) {
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        self.subscribeToKeyboardNotifications()
        
        self.navigationController?.setToolbarHidden(false, animated: true)
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.unsubscribeFromKeyboardNotifications()
    }

    @IBAction func pickAnImage(sender: UIBarButtonItem) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func takeAnPhoto(sender: UIBarButtonItem) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        self.presentViewController(imagePicker, animated: true, completion: nil)

    }
    
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        if let pickedImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            self.imageView.image = pickedImage
            self.shareButton.enabled = true
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        
    }
    
    
    func textFieldDidBeginEditing(textField: UITextField) {
        textField.text = ""
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:"    , name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:"    , name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name:
            UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name:
            UIKeyboardWillHideNotification, object: nil)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        self.view.frame.origin.y -= getKeyboardHeight(notification)
    }
    
    func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y += getKeyboardHeight(notification)
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.CGRectValue().height
    }
    
    func save() {
        //Create the meme
        var meme = Meme(topText:topTextField.text, bottomText: bottomTextField.text,
            image: imageView.image, memedImage: memedImage)
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
    }
    
    @IBAction func shareButtonTapped(sender: UIBarButtonItem) {
        memedImage = generateMemedImage()
        let activityVC = UIActivityViewController(activityItems: [memedImage!], applicationActivities: nil)
        activityVC.completionWithItemsHandler = {
            activity, success, items, error in
            self.save()
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        self.presentViewController(activityVC, animated: true, completion: nil)
    }

    
    func generateMemedImage() -> UIImage
    {
        self.navigationController?.setToolbarHidden(true, animated: true)
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        self.view.drawViewHierarchyInRect(self.view.frame,
            afterScreenUpdates: true)
        let memedImage : UIImage =
        UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        self.navigationController?.setToolbarHidden(false, animated: true)
        
        return memedImage
    }

    @IBAction func cancelButtonTapped(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}

