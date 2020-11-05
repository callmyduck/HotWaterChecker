import UIKit

extension R {

    public enum Font {

        // System

        public static func thin(_ size: CGFloat) -> UIFont {
            UIFont.systemFont(ofSize: size, weight: .thin)
        }

        public static func light(_ size: CGFloat) -> UIFont {
            UIFont.systemFont(ofSize: size, weight: .light)
        }

        public static func regular(_ size: CGFloat) -> UIFont {
            UIFont.systemFont(ofSize: size, weight: .regular)
        }

        public static func medium(_ size: CGFloat) -> UIFont {
            UIFont.systemFont(ofSize: size, weight: .medium)
        }

        public static func semibold(_ size: CGFloat) -> UIFont {
            UIFont.systemFont(ofSize: size, weight: .semibold)
        }

        public static func heavy(_ size: CGFloat) -> UIFont {
            UIFont.systemFont(ofSize: size, weight: .heavy)
        }

        public static func bold(_ size: CGFloat) -> UIFont {
            UIFont.systemFont(ofSize: size, weight: .bold)
        }
    }
}
