//
//  ShieldConfigurationExtension.swift
//  ShieldConfigurationExtension
//
//  Created by IPS-157 on 12/09/22.
//

import ManagedSettings
import ManagedSettingsUI
import UIKit
import SwiftUI

// Override the functions below to customize the shields used in various situations.
// The system provides a default appearance for any methods that your subclass doesn't override.
// Make sure that your class name matches the NSExtensionPrincipalClass in your Info.plist.
class ShieldConfigurationExtension: ShieldConfigurationDataSource {
    override func configuration(
            shielding application: Application
    ) -> ShieldConfiguration {
        let themeColor = UIColor(named: "light_Pink")!
        return ShieldConfiguration(backgroundBlurStyle: .regular,
                                   backgroundColor: themeColor,

                                   icon: UIImage(named: "SettingsMrArturLogo"),
                                   title: ShieldConfiguration.Label(
                                           text: self.getTitle(),
                                           color: UIColor(named: "primary_Blue")!
                                   ),
                                   subtitle: ShieldConfiguration.Label(
                                           text: self.getSubTitle(),
                                           color: UIColor(named: "primary_Blue")!
                                   ),
                                   primaryButtonLabel: ShieldConfiguration.Label(
                                           text: self.getPrimaryButtonLabel(),
                                           color: .white
                                   ),
                                   primaryButtonBackgroundColor: UIColor(named: "primary_Red"),
                                   secondaryButtonLabel: nil
        )
    }
    
    override func configuration(
            shielding application: Application,
            in category: ActivityCategory
    ) -> ShieldConfiguration {
        // Customize the shield as needed for applications shielded because of their category.
        let themeColor = UIColor(named: "light_Pink")!
        return ShieldConfiguration(backgroundBlurStyle: .regular,
                                   backgroundColor: themeColor,

                                   icon: UIImage(named: "SettingsMrArturLogo"),
                                   title: ShieldConfiguration.Label(
                                           text: self.getTitle(),
                                           color: UIColor(named: "primary_Blue")!
                                   ),
                                   subtitle: ShieldConfiguration.Label(
                                           text: self.getSubTitle(),
                                           color: UIColor(named: "primary_Blue")!
                                   ),
                                   primaryButtonLabel: ShieldConfiguration.Label(
                                           text: self.getPrimaryButtonLabel(),
                                           color: UIColor(named: "primary_Blue")!
                                   ),
                                   primaryButtonBackgroundColor: UIColor(named: "primary_Red"),
                                   secondaryButtonLabel: nil
        )
    }
    
    override func configuration(
            shielding webDomain: WebDomain
    ) -> ShieldConfiguration {
        // Customize the shield as needed for web domains.
        let themeColor = UIColor(named: "light_Pink")!
        return ShieldConfiguration(backgroundBlurStyle: .regular,
                                   backgroundColor: themeColor,

                                   icon: UIImage(named: "SettingsMrArturLogo"),
                                   title: ShieldConfiguration.Label(
                                           text: self.getTitle(),
                                           color: UIColor(named: "primary_Blue")!
                                   ),
                                   subtitle: ShieldConfiguration.Label(
                                           text: self.getSubTitle(),
                                           color: UIColor(named: "primary_Blue")!
                                   ),
                                   primaryButtonLabel: ShieldConfiguration.Label(
                                           text: self.getPrimaryButtonLabel(),
                                           color: UIColor(named: "primary_Blue")!
                                   ),
                                   primaryButtonBackgroundColor: UIColor(named: "primary_Red"),
                                   secondaryButtonLabel: nil
        )
    }
    
    override func configuration(
            shielding webDomain: WebDomain,
            in category: ActivityCategory
    ) -> ShieldConfiguration {
        // Customize the shield as needed for web domains shielded because of their category.
        let themeColor = UIColor(named: "light_Pink")!
        return ShieldConfiguration(backgroundBlurStyle: .regular,
                                   backgroundColor: themeColor,

                                   icon: UIImage(named: "SettingsMrArturLogo"),
                                   title: ShieldConfiguration.Label(
                                           text: self.getTitle(),
                                           color: UIColor(named: "primary_Blue")!
                                   ),
                                   subtitle: ShieldConfiguration.Label(
                                           text: self.getSubTitle(),
                                           color: UIColor(named: "primary_Blue")!
                                   ),
                                   primaryButtonLabel: ShieldConfiguration.Label(
                                           text: self.getPrimaryButtonLabel(),
                                           color: UIColor(named: "primary_Blue")!
                                   ),
                                   primaryButtonBackgroundColor: UIColor(named: "primary_Red"),
                                   secondaryButtonLabel: nil
        )
    }
    
    func getTitle() -> String {
        @AppStorage(
            ExtensionSharedAppGroupService.keys.SHIELD_MESSAGE_TITLE,
            store: ExtensionSharedAppGroupService.sharedDefault
        ) var shieldTitle : String = "Hey, time Up!"
        return shieldTitle
    }
    
    func getSubTitle() -> String {
        @AppStorage(
            ExtensionSharedAppGroupService.keys.SHIELD_MESSAGE_SUB_TITLE,
            store: ExtensionSharedAppGroupService.sharedDefault
        ) var shieldSubTitle : String = "Go get some rest. That concludes your time on the screen."
        return shieldSubTitle
    }

    func getPrimaryButtonLabel() -> String {
        @AppStorage(
            ExtensionSharedAppGroupService.keys.SHIELD_MESSAGE_PRIMARY_BUTTON_LABEL,
            store: ExtensionSharedAppGroupService.sharedDefault
        ) var buttonLabel : String = "Go it"
        return buttonLabel
    }
}

extension UIColor {
   convenience init(rgbColorCodeRed red: Int, green: Int, blue: Int, alpha: CGFloat) {

     let redPart: CGFloat = CGFloat(red) / 255
     let greenPart: CGFloat = CGFloat(green) / 255
     let bluePart: CGFloat = CGFloat(blue) / 255
       
     self.init(red: redPart, green: greenPart, blue: bluePart, alpha: alpha)
   }
}
