# TYPopupController
TYPopupController is presenting view controller or view as popups of other view controller.

## Requirements
* Xcode 7 or higher
* iOS 7.0 or higher
* ARC

### ScreenShot

![image](https://github.com/12207480/TYPopupController/blob/master/ScreenShot/TYPopupController.gif)

## Usage

```objc

// popup viewcontroller
TYPopupController *popupController = [TYPopupController popupControllerWithController:[PopViewController new] size:CGSizeMake(300, 250) popupStyle:TYPopupStyleDropDown];
popupController.adjustKeyboardShowHide = YES;
[self presentViewController:popupController animated:YES completion:nil];
    
// popup view
UIView *popView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 200, 300)];
TYPopupController *popupController = [TYPopupController popupControllerWithView:popView];
popupController.backgoundTapDismissEnable = YES;
[self presentViewController:popupController animated:YES completion:nil];

```

### Contact
如果你发现bug，please pull reqeust me <br>
如果你有更好的改进，please pull reqeust me <br>
