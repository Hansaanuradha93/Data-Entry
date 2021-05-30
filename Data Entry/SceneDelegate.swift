import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let controller = RegisterViewController.create(viewModel: RegisterViewModel())
//        controller.navigationController?.isNavigationBarHidden = true
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = UINavigationController(rootViewController: controller)
        self.window = window
        window.makeKeyAndVisible()
    }
}

