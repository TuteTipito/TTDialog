# TTDialog


![Example](https://github.com/TuteTipito/TTDialog/blob/master/screenshotTTDialog.png)

## Usage
```objective-c
#import "TTDialog.h"

...

{
    [TTDialog showDialog];
}
```
## Important!!
* Add the **QuartzCore** framework to your project.


## Create your own view

* crear un .xib

--
![00](https://github.com/TuteTipito/images/blob/master/TTDialog00.png)
--
![01](https://github.com/TuteTipito/images/blob/master/TTDialog01.png)
--
![02](https://github.com/TuteTipito/images/blob/master/TTDialog02.png)
--
![03](https://github.com/TuteTipito/images/blob/master/TTDialog03.png)
--
![04](https://github.com/TuteTipito/images/blob/master/TTDialog04.png)

--

una vez creado se puede setear ese xib por default llamando a
```objective-c
[TTDialog setDefaultNibName:@"<#nib_name#>"];
```
para que todas las veces que se llame a showDialog nos abra por default ese xib


o si es por un caso unico y especial se puede llamar a showDialog mandandole por parametro el NibName de la View
```objective-c
[TTDialog showDialogWithNibName:@"<#nib_name#>"];
```

## Usage

para mejor uso se pueden usar metodos como estos para enviarle por parametro una vista especifica donde se abra el `TTDialog` o el delegate para futuros callouts.
```objective-c
+ (void) showDialogWithNibName:(NSString *)nibName;
+ (void) showDialogWithNibName:(NSString *)nibName andDelegate:(id)delegate_;
+ (void) showDialogWithNibName:(NSString *)nibName inView:(UIView*)parentVew;

+ (void) showDialogWithNibName:(NSString *)nibName inView:(UIView*)parentVew andDelegate:(id)delegate_;
```


## Customization

`TTDialog` can be customized via the following methods:
```objective-c
+ (void) setDefaultNibName:(NSString *)nibName;     // default is @"TTDialog"
+ (void) setShouldBounce:(BOOL)bounce;              // default is YES
+ (void) setShouldRotate:(BOOL)rotate;              // default is NO
+ (void) setSmallerToBigger:(BOOL)smallerToBigger_; // default is YES
+ (void) setAnimationDuration:(double)duration;     // defualt is 0.5
```

