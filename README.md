# AndroidLoader
This is a very simple android like loader which has a label and a default activity indicator. You can change the text on the loader as per your requirement. This also has a Android's Snack bar which looks like a toast message with a image. This can be customized as per your requirement.There are various common messages we need in every projects like Success , failure and warning/ Alert messages. Where disturb the user by showing default Alert Box with OK button. Hence using this library it is just 1 line to go and your job is done. Pass the required snackBarType and the icon is set automatically. The code is simple and clean which is easily understood.You can change the assets as per your requirements. 

 The loader is called as follows:
 
*Create a object in your class where you need it*
 
    let myCustomLoader = AndroidLoaderView()
    let mySnackBar = AndroidSnackBar()
    
    myCustomLoader.showLoaderOnView(currentView: self.view, text: "Loading...")
    mySnackBar.showSnackBarView(currentView: self.view, withText: "Profile updated successfully", snackBarType:SnackBarType.SnackBarForSuccess)

*To hide the loader*
  
      myCustomLoader.hideLoaderFromView()
      mySnackBar.hideSnackBarFromView()

*If you have any suggestions or inputs then you are most welcome. You can write me mail at* nsdoiphode@gmail.com 
*Please keep your Condemn with you i have many others things to entertain. :) Happy Coding*
