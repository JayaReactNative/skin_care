mixin AppLocale {
  // static const String title = 'title';
  //
  // static const Map<String, dynamic> EN = {title: 'Localization'};
  // static const Map<String, dynamic> KM = {title: 'ការធ្វើមូលដ្ឋានីយកម្ម'};
  // static const Map<String, dynamic> JA = {title: 'ローカリゼーション'};
// english
  static const Map<String, String> enUS = {
    //onbording Screen
    'lbl_slider_title': 'Free analysis of skin',
    'lbl_slider_desc':
        'Create a dedicated "Skincare Consultation" section where users can ask questions, seek advice, and provide feedback.',
    'lbl_slider_title2': 'Doctor given treatment kit',
    'lbl_slider_desc2':
        'Create a dedicated "Skincare Consultation" section where users can ask questions, seek advice, and provide feedback.',
    //**login signup
    'lbl_login': 'Login',
    'lbl_signup': 'Signup',
    'lbl_continue_as_guest': 'Continue as a Guest',

    //login Screen
    'lbl_login_heading': "Welcome back! Glad to see you, Again!",
    'lbl_email': 'Email',
    'lbl_email_example': "Email",
    'lbl_password': 'Password',
    'lbl_forgot_password': 'Forgot Password',
    'lbl_dont_have_account': "Don’t have an account?",
    'lbl_login_with': "or login with",
    'lbl_button_login': "Login",

    //forget password screen
    'lbl_title_forgot_password': 'Forget your password',
    'lbl_text':
        "please enter the email address you'd like your password reset information sent to ",
    'lbl_hint_email': 'Email',
    'lbl_button_forgot_password': 'Forgot Password',
    'lbl_error_text': 'Please enter an email address',
    'lbl_error_text_invalid_email': 'Please enter a valid email address',

    //sing Up Screen
    'lbl_first_name': 'First Name',
    'lbl_last_name': 'Last Name',
    'lbl_phone_number': 'Phone no.',
    'lbl_signup_email': 'Email',
    'lbl_signup_password': 'Password',
    'lbl_signup_confirm_pass': 'Confirm Password',
    'lbl_read_and_agree': "I have read and agree to the ",
    'lbl_privacy_policy': 'privacy policy',
    'lbl_terms_condition': "\nTerms & Conditions",
    'lbl_already_have_account': "Already have an account? ",
    'lbl_already_login': "Login Now",
    'lbl_location': "Location",
    'lbl_signup_button_text': "Signup",

    //home screen
    'lbl_appbar_title': 'Welcome! Aloo Marin',
    'lbl_search_bar_hint': 'What are you looking for',
    'lbl_products': 'Products',
    'lbl_product_related_symptoms': 'Product related to Sumtoms',

    // Bottom nav bar
    'lbl_nav_home': 'Home',
    'lbl_nav_history': 'History',
    'lbl_nav_chat': 'Chat',
    'lbl_nav_profile': 'Profile',
    'lbl_nav_favourite': 'Favourite',

    //Products screen
    'lbl_screen_appbar_title': 'Products',

    // Favourite screen
    'lbl_f_appbar_title': 'Favourite',
    'lbl_empty_list': 'Empty List!',
    'lbl_add_items': 'Please add items to wishlist',

    //Profile Screen
    'lbl_appbar_profile': 'Edit Profile',
    'lbl_full_name': 'Full Name',
    'lbl_profile_email': 'Email',
    'lbl_phone_no': 'Phone no.',
    'lbl_update': 'Update',

    //Chat screen
    'lbl_dialogue_title': 'Clear Chat',
    'lbl_dialogue_content': 'Are you sure you want to clear this chat?',
    'lbl_dialogue_action_cancel': 'Cancel',
    'lbl_dialogue_action_delete': 'Delete',
    'lbl_your_message': 'Your message',

    //Setting Screen
    'lbl_setting': 'Settings',
    'lbl_language': 'Language',
    'lbl_my_photos': 'My Photos',
    'lbl_change_password': 'Change Password',
    'lbl_privacy_security': 'Privacy and security',
    'lbl_help': 'Help',
    'lbl_policies': 'Policies',
    'lbl_sign_out': 'Sign Out',
    'lbl_set_dialogue_title': 'Sign Out',
    'lbl_set_dialogue_content': 'Are you sure you want to sign out?',
    'lbl_set_dialogue_action_cancel': 'Cancel',
    'lbl_set_dialogue_action_sign_out': 'Sign Out',
  };

// french
  static const Map<String, String> frFR = {
    // Onboarding Screen
    'lbl_slider_title': 'Analyse gratuite de la peau',
    'lbl_slider_desc':
        'Créez une section dédiée "Consultation de soins de la peau" où les utilisateurs peuvent poser des questions, demander des conseils et donner leur avis.',
    'lbl_slider_title2': 'Kit de traitement fourni par le médecin',
    'lbl_slider_desc2':
        'Créez une section dédiée "Consultation de soins de la peau" où les utilisateurs peuvent poser des questions, demander des conseils et donner leur avis.',

    // Login Signup
    'lbl_login': 'Connexion',
    'lbl_signup': 'Inscription',
    'lbl_continue_as_guest': 'Continuer en tant qu\'invité',

    // Login Screen
    'lbl_login_heading':
        "Content de te revoir! Heureux de vous revoir, encore!",
    'lbl_email': 'E-mail',
    'lbl_email_example': "E-mail",
    'lbl_password': 'Mot de passe',
    'lbl_forgot_password': 'Mot de passe oublié',
    'lbl_dont_have_account': "Vous n'avez pas de compte?",
    'lbl_login_with': "ou connectez-vous avec",
    'lbl_button_login': "Connexion",

    // Forget Password Screen
    'lbl_title_forgot_password': 'Mot de passe oublié',
    'lbl_text':
        "veuillez entrer l'adresse e-mail à laquelle vous souhaitez envoyer les informations de réinitialisation de votre mot de passe",
    'lbl_hint_email': 'E-mail',
    'lbl_button_forgot_password': 'Mot de passe oublié',
    'lbl_error_text': 'Veuillez entrer une adresse e-mail',
    'lbl_error_text_invalid_email': 'Veuillez entrer une adresse e-mail valide',

    // Sign Up Screen
    'lbl_first_name': 'Prénom',
    'lbl_last_name': 'Nom',
    'lbl_phone_number': 'Numéro de téléphone',
    'lbl_signup_email': 'E-mail',
    'lbl_signup_password': 'Mot de passe',
    'lbl_signup_confirm_pass': 'Confirmer le mot de passe',
    'lbl_read_and_agree': "J'ai lu et j'accepte la ",
    'lbl_privacy_policy': 'politique de confidentialité',
    'lbl_terms_condition': "\nTermes et Conditions",
    'lbl_already_have_account': "Vous avez déjà un compte? ",
    'lbl_already_login': "Connectez-vous maintenant",
    'lbl_location': "Localisation",
    'lbl_signup_button_text': "Inscription",

    // Home Screen
    'lbl_appbar_title': 'Bienvenue! Aloo Marin',
    'lbl_search_bar_hint': 'Que cherchez-vous',
    'lbl_products': 'Produits',
    'lbl_product_related_symptoms': 'Produits liés aux symptômes',

    // Bottom Nav Bar
    'lbl_nav_home': 'Accueil',
    'lbl_nav_chat': 'Chat',
    'lbl_nav_profile': 'Profil',
    'lbl_nav_favourite': 'Favoris',

    // Products Screen
    'lbl_screen_appbar_title': 'Produits',

    // Favourite Screen
    'lbl_f_appbar_title': 'Favoris',
    'lbl_empty_list': 'Liste vide!',
    'lbl_add_items': 'Veuillez ajouter des articles à la liste de souhaits',

    // Profile Screen
    'lbl_appbar_profile': 'Modifier le profil',
    'lbl_full_name': 'Nom complet',
    'lbl_profile_email': 'E-mail',
    'lbl_phone_no': 'Numéro de téléphone',
    'lbl_update': 'Mettre à jour',

    // Chat Screen
    'lbl_dialogue_title': 'Effacer le chat',
    'lbl_dialogue_content': 'Êtes-vous sûr de vouloir effacer ce chat?',
    'lbl_dialogue_action_cancel': 'Annuler',
    'lbl_dialogue_action_delete': 'Supprimer',
    'lbl_your_message': 'Votre message',

    // Setting Screen
    'lbl_settingd': 'Paramètres',
    'lbl_language': 'Langue',
    'lbl_my_photos': 'Mes photos',
    'lbl_change_password': 'Changer le mot de passe',
    'lbl_privacy_security': 'Confidentialité et sécurité',
    'lbl_help': 'Aide',
    'lbl_policies': 'Politiques',
    'lbl_sign_out': 'Déconnexion',
    'lbl_set_dialogue_title': 'Déconnexion',
    'lbl_set_dialogue_content': 'Êtes-vous sûr de vouloir vous déconnecter?',
    'lbl_set_dialogue_action_cancel': 'Annuler',
    'lbl_set_dialogue_action_sign_out': 'Déconnexion',
  };

// spanish
  static const Map<String, String> esES = {
    // Onboarding Screen
    'lbl_slider_title': 'Análisis gratuito de la piel',
    'lbl_slider_desc':
        'Cree una sección dedicada a la "Consulta de cuidado de la piel" donde los usuarios puedan hacer preguntas, buscar consejos y proporcionar comentarios.',
    'lbl_slider_title2': 'Kit de tratamiento proporcionado por el médico',
    'lbl_slider_desc2':
        'Cree una sección dedicada a la "Consulta de cuidado de la piel" donde los usuarios puedan hacer preguntas, buscar consejos y proporcionar comentarios.',

    // Login Signup
    'lbl_login': 'Iniciar sesión',
    'lbl_signup': 'Registrarse',
    'lbl_continue_as_guest': 'Continuar como invitado',

    // Login Screen
    'lbl_login_heading': "¡Bienvenido de nuevo! ¡Me alegra verte, otra vez!",
    'lbl_email': 'Correo electrónico',
    'lbl_email_example': "Correo electrónico",
    'lbl_password': 'Contraseña',
    'lbl_forgot_password': 'Olvidé mi contraseña',
    'lbl_dont_have_account': "¿No tienes una cuenta?",
    'lbl_login_with': "o iniciar sesión con",
    'lbl_button_login': "Iniciar sesión",

    // Forget Password Screen
    'lbl_title_forgot_password': 'Olvidaste tu contraseña',
    'lbl_text':
        "por favor ingresa la dirección de correo electrónico a la que deseas que te enviemos la información para restablecer tu contraseña",
    'lbl_hint_email': 'Correo electrónico',
    'lbl_button_forgot_password': 'Olvidé mi contraseña',
    'lbl_error_text': 'Por favor, ingresa una dirección de correo electrónico',
    'lbl_error_text_invalid_email':
        'Por favor, ingresa una dirección de correo electrónico válida',

    // Sign Up Screen
    'lbl_first_name': 'Nombre',
    'lbl_last_name': 'Apellido',
    'lbl_phone_number': 'Número de teléfono',
    'lbl_signup_email': 'Correo electrónico',
    'lbl_signup_password': 'Contraseña',
    'lbl_signup_confirm_pass': 'Confirmar contraseña',
    'lbl_read_and_agree': "He leído y estoy de acuerdo con la ",
    'lbl_privacy_policy': 'política de privacidad',
    'lbl_terms_condition': "\nTérminos y Condiciones",
    'lbl_already_have_account': "¿Ya tienes una cuenta? ",
    'lbl_already_login': "Inicia sesión ahora",
    'lbl_location': "Ubicación",
    'lbl_signup_button_text': "Registrarse",

    // Home Screen
    'lbl_appbar_title': '¡Bienvenido! Aloo Marin',
    'lbl_search_bar_hint': 'Qué estás buscando',
    'lbl_products': 'Productos',
    'lbl_product_related_symptoms': 'Producto relacionado con los síntomas',

    // Bottom Nav Bar
    'lbl_nav_home': 'Inicio',
    'lbl_nav_chat': 'Chat',
    'lbl_nav_profile': 'Perfil',
    'lbl_nav_favourite': 'Favoritos',

    // Products Screen
    'lbl_screen_appbar_title': 'Productos',

    // Favourite Screen
    'lbl_f_appbar_title': 'Favoritos',
    'lbl_empty_list': '¡Lista vacía!',
    'lbl_add_items': 'Por favor, añade artículos a la lista de deseos',

    // Profile Screen
    'lbl_appbar_profile': 'Editar perfil',
    'lbl_full_name': 'Nombre completo',
    'lbl_profile_email': 'Correo electrónico',
    'lbl_phone_no': 'Número de teléfono',
    'lbl_update': 'Actualizar',

    // Chat Screen
    'lbl_dialogue_title': 'Borrar chat',
    'lbl_dialogue_content': '¿Estás seguro de que deseas borrar este chat?',
    'lbl_dialogue_action_cancel': 'Cancelar',
    'lbl_dialogue_action_delete': 'Eliminar',
    'lbl_your_message': 'Tu mensaje',

    // Setting Screen
    'lbl_settingd': 'Configuración',
    'lbl_language': 'Idioma',
    'lbl_my_photos': 'Mis fotos',
    'lbl_change_password': 'Cambiar contraseña',
    'lbl_privacy_security': 'Privacidad y seguridad',
    'lbl_help': 'Ayuda',
    'lbl_policies': 'Políticas',
    'lbl_sign_out': 'Cerrar sesión',
    'lbl_set_dialogue_title': 'Cerrar sesión',
    'lbl_set_dialogue_content': '¿Estás seguro de que deseas cerrar sesión?',
    'lbl_set_dialogue_action_cancel': 'Cancelar',
    'lbl_set_dialogue_action_sign_out': 'Cerrar sesión',
  };
}
