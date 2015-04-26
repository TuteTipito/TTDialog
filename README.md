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

## Customization

* crear un .xib

01)![00](https://github.com/TuteTipito/images/blob/master/TTDialog00.png)

02)![01](https://github.com/TuteTipito/images/blob/master/TTDialog01.png)

03)![02](https://github.com/TuteTipito/images/blob/master/TTDialog02.png)

04)![03](https://github.com/TuteTipito/images/blob/master/TTDialog03.png)

05)![04](https://github.com/TuteTipito/images/blob/master/TTDialog04.png)


una vez creado se puede setear ese xib por default llamando a
```objective-c
[TTDialog setDefaultNibName:@"<#nib_name#>"];
```
antes de 
```objective-c
[TTDialog showDialog];
```
para que todas las veces que se llame a showDialog nos abra por default ese xib


o si es por un caso unico y especial se puede llamar a showDialog mandandole por parametro el NibName de la View
```objective-c
[TTDialog showDialogWithNibName:@"<#nib_name#>"];
```
