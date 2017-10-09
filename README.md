# AndroidLoader
This is a very simple android like loader which has a label and a default activity indicator. You can change the text on the loader as per your requirement.

For *Cocoa Pods*

You can also install pods to use this framework

    pod 'AndroidLoader', git: => 'https://github.com/nishigandhadoiphode/AndroidLoader'

 
 The loader is called as follows:
 
*Create a object in your class where you need it*
 
    let myCustomLoader = AndroidLoaderView()
    
    myCustomLoader.showLoaderOnView(parentView: self.view, text: "Loading...")
  
*To hide the loader*
  
      myCustomLoader.hideLoaderFromView(parentView: self.view)
