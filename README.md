# TTDialog


!(https://github.com/TuteTipito/TTDialog/blob/master/screenshotTTDialog.png)

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

una vez creado se puede setear ese xib por default llamando a
```objective-c
[TTDialog setDefaultNibName:@<#nib_name#>];
```
antes de 
```objective-c
[TTDialog showDialog];
```
para que todas las veces que se llame a showDialog nos abra por default ese xib


o si es por un caso unico y especial se puede setear el NibName justo antes de llamar a showDialog
```objective-c
[TTDialog setNibName:@<#nib_name#>];
[TTDialog showDialog];
```
o mas simple
```objective-c
[TTDialog showDialogWithNibName:@<#nib_name#>];
```
