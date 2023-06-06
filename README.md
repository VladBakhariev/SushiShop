# SushiShop
Сlient-server iOS application - sushi delivery service

<h3><strong>Description:</strong></h3>
<p>The SushiShop app is a client-server <strong>iOS</strong> application built using the Swift programming language. It serves as a platform for a sushi delivery service. The app utilizes <strong>SwiftUI</strong> for the user interface and <strong>Firebase</strong> for backend integration.</p>
<p>Upon launching the app, the main scene is displayed, which is determined by the user's authentication status. If the user is authenticated and their UID matches the designated admin UID, the AdminOrdersView is shown, providing administrative functionalities for managing orders. For other authenticated users, the MainTabBar is presented, featuring various tabs and views related to sushi ordering and delivery.</p>
<p>If the user is not authenticated, the AuthView is displayed, allowing them to sign in or create an account.</p>
<p>To enable Firebase integration in Xcode, the SushiShopApp utilizes the AppDelegate class, which conforms to the UIApplicationDelegate protocol. The FirebaseApp is configured within the application(_:didFinishLaunchingWithOptions:) method of the AppDelegate class.</p>
<h3 class="_04xlpA direction-ltr align-start para-style-body"><strong><span class="WdYUQQ text-decoration-none text-strikethrough-none">Technologies and frameworks:</span></strong></h3>
<p class="_04xlpA direction-ltr align-start para-style-body"><span class="WdYUQQ text-decoration-none text-strikethrough-none">Swift, SwiftUI, UIKit, Foundation, Firebase, StorageService</span></p>
<h3><span class="WdYUQQ text-decoration-none text-strikethrough-none"><strong>Conclusion</strong>:</span></h3>
<p>Overall, the SushiShop app provides a seamless and intuitive user experience for sushi enthusiasts to order their favorite dishes and have them delivered conveniently.</p>
