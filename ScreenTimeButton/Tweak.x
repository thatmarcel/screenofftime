%hook STLockoutViewController
    - (UIButton*) mainButton {
        UIButton *button = %orig;
        button.hidden = true;
        button.userInteractionEnabled = false;
        return button;
    }
%end
