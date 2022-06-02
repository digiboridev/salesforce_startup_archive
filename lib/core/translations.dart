import 'package:get/get.dart';

class Trs extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en': {
          'Good morning': 'Good morning🌞', // AL2
          'The password you entered is expired': // AL2
              'The password you entered is expired',
          'Back to the login screen': 'Back to the login screen', // AL2
          'Hebrew': 'Hebrew',
          'English': 'English',
          'Choose language': 'Choose language', // P8
          'Personal details': 'Personal details', // P1
          'Change password': 'Change password', // P1
          'Terms an conditions': 'Terms and conditions', // P1
          'Log out': 'Log out', // P1
          'Password change': 'Password change', // P4
          'Current password': 'Current password', // P4
          'New password': 'New password', // P4
          'New password again': 'New password again', // P4
          'Save': 'Save', // anywhere
          'Cancel': 'Cancel', // anywhere
          'First name': 'First name', // P2
          'Last name': 'Last name', // P2
          'Phone': 'Phone', // P2
          'Passwords are not the same': 'Passwords are not the same', // P4
          'Error': 'Error', // anywhere
          'Restricted for offline mode':
              'Restricted for offline mode', // Popups with error
          'Email': 'Email', // P2
          'User loading error': 'User loading error', // Popups with error
          'try again': 'try again', // Popups with error
          'Understood': 'Understood', // AL 14
          'Customer loading error':
              'Customer loading error', // Popups with error
          'Search results': 'Search results', // SE2
          'Found': 'Found', // SE2
          'Results of': 'Results of', // SE2
          'No results were found for this product but we have similar products':
              'No results were found for this product but we have similar products', // SE3
          'Deals': 'Deals', // H1
          'All Deals': 'All Deals', // H1
          'Recomended for you': 'Recomended for you', // H1
          'All recomended': 'All recomended', // H1
          'To all newcomers': 'To all newcomers', // H1
          'New Products': 'New products', // H1
          'List of deficiencies': 'List of deficiencies', // H1
          'You may be missing': 'You may be missing', // H1
          'Search product': 'Search product', // Header
          'Quantity': 'Quantity', // PS4
          'Recommended quantity': 'Recommended quantity', // PS1
          'Minimum order': 'Minimum order', // PS1
          'units per': 'units per', // PS1
          'Home': 'Home', // bottombar
          'Favorites': 'Favorites', // bottombar
          'Catalog': 'Catalog', // bottombar
          'Order': 'Order', // bottombar
          'Brands': 'Brands', // C2
          'Families': 'Families', // C2
          'We will update as soon as it returns to stock':
              'We will update as soon as it returns to stock', // PS1
          'Not in stock, update when he gets back?':
              'Not in stock, update when he gets back?', // PS1
          'Alternative product': 'Alternative product',
          'Back to original product': 'Back to original product', // PS1
          'free pallets added!': 'free pallets added!', // PS1
          'This product was partially supplied, supplied':
              'This product was partially supplied, supplied', // PS1
          'Supplied!': 'Supplied!', // PS1
          'Here will come an error message':
              'Here will come an error message', // PS1
          'You may be\nmissing!': 'You may be\nmissing!', // PS1
          'Zero': 'Zero', // PS1
          'Unit': 'Unit', // PS1
          'Inner': 'Inner', // PS1
          'Carton': 'Carton', // PS1
          'Palete': 'Palete', // PS1
          'units in': 'units in', // PS1
          'More results': 'More results', // SE3
          'Code': 'Code', // PP5
          'Barcode': 'Barcode', // PP5
          'About the product': 'About the product', // PP5
          'The Rabbinical Society': 'The Rabbinical Society', // PP5
          'Shop': 'Shop', // PP5
          'Get': 'Get', // PP5
          'Substitutes for this product': 'Substitutes for this product', // PP5
          'Password condition':
              'Passwords must contain at least 8 characters, 1 capital letter, 1 small letter, a number and a special character',
          'Current': 'Current', // P3
          'New': 'New', // P3
          'Password display in asterisks':
              'Password display in asterisks', // P3
          'For details please contact the hotline':
              'For details please contact the hotline', // P3
          'Passwords must not match': 'Passwords must not match', // P3
          'New password is not match': 'New password is not match', // P3
          'password is empty': 'password is empty', // P3
          'Cancellation': 'Cancellation', // P3
          'Add the entire list to cart': 'Add the entire list to cart', // F4
          'Sorting': 'Sorting', // F4
          'Belongs on the list': 'Belongs on the list', // F4
          'Remove from favorites': 'Remove from favorites', // F4
          'No product transfer yet To this list':
              'No product transfer yet\nTo this list', // F4
          'Save your products on the page Favorites by clicking on -':
              'Save your products on the page\nFavorites by clicking on -', // F4
          'On the favorites page, click on -':
              'On the favorites page, click on -', // F4
          'Let you move the product To one of the lists you opened':
              'Let you move the\nproduct\nTo one of the lists you opened', // F4
          'Delete the list': 'Delete the list', // F4
          'New shopping list': 'New shopping list', // F4
          'List Name': 'List Name', // F4
          "Good, you've made a new list!":
              "Good, you've made a new list!", // F4
          'To fill out the list click on the three points on the left side of the product':
              'To fill out the list click on the three\npoints on the left side of the product', // F4
          'Shopping cart': 'Shopping cart', // SD3
          'Your shopping cart is empty': 'Your shopping cart is empty', // SD3
          'To start an order from the recommended list':
              'To start an order from the recommended list', // SD3
          'Emptying All Basket': 'Emptying\nAll Basket', // SD3
          'Save As a shopping list': 'Save\nAs a shopping list', // SD3
          'Add Products From the catalog':
              'Add Products\nFrom the catalog', // SD3
          'Saving as a shopping list': 'Saving as a shopping list', // SD3
          'The list will be kept in the preferred area':
              'The list will be kept in the preferred area', // SD3
          'Search branch':
              'Search branch', // search field when header show related brunch list
          'Our focus is open': 'Our focus is open', // H6
          'All brunches': 'All brunches', // H5
          'Terms of Use': 'Terms of Use', // AL14
          'Close': 'Close',
          'No materials': 'No materials', // Catalog
          'Filtering': 'Filtering', // Catalog
          'Filter by': 'Filter by', // Catalog
          'Not implemented': 'Not implemented', // Popups with error
          'Materials loading error':
              'Materials loading error', // Popups with error
          'Favorites loading error':
              'Favorites loading error', // Popups with error
          'Recomended List': 'Recomended List', // header
          'All branches': 'All branches', // header
          'Client ID': 'Client ID:', // header
          'Last order date': 'Last order date:', // header
          'Distance': 'Distance:', // header
        },
        'he': {
          'Good morning': 'בוקר טוב🌞',
          'The password you entered is expired': 'תוקף הסיסמה שהזנת פג',
          'Back to the login screen': 'חזרה למסך הכניסה',
          'Hebrew': "עברית",
          'English': 'English',
          'Choose language': 'בחר שפה',
          'Personal details': 'פרטים אישיים',
          'Change password': 'החלפת שפה עברית',
          'Terms an conditions': 'תקנון ותנאי שימוש',
          'Log out': 'התנתק',
          'Password change': 'החלפת סיסמא',
          'Current password': 'סיסמא נוכחית',
          'New password': 'סיסמא חדשה',
          'New password again': 'סיסמא חדשה בשנית',
          'Save': 'שמירה',
          'Cancel': 'ביטול',
          'Passwords are not the same': 'הסיסמאות לא זהות',
          'Error': 'תקלה',
          'Restricted for offline mode': 'מותאם רק למצב לא מקוון',
          'First name': 'שם פרטי',
          'Last name': 'שם משפחה',
          'Phone': 'טלפון',
          'Email': 'דוא”ל',
          'User loading error': 'שגיאה בעת טעינת המשתמש',
          'try again': 'נסה שוב',
          'Understood': 'מובן',
          'Customer loading error': 'שגיאה בהעלאת גרסת הלקוח',
          'Search results': 'תוצאות חיפוש',
          'Found': 'נמצא',
          'Results of': 'תוצאות של',
          'No results were found for this product but we have similar products':
              'לא נמצאו תוצאות לחיפוש המבוקש אבל יש לנו מוצרים דומים שיכולים להתאים',
          'Deals': 'מבצעים',
          'All Deals': 'כל הדילים',
          'Recomended for you': 'מומלצים עבורך',
          'All recomended': 'לכל המומלצים',
          'To all newcomers': 'לכל החדשים',
          'New Products': 'מוצרים חדשים',
          'List of deficiencies': 'רשימה של הגדרות',
          'You may be missing': 'אל תפספסו',
          'Search product': 'חיפוש מוצרים',
          'New': 'חדש',
          'Quantity': 'כמות',
          'Recommended quantity': 'כמות מומלצת',
          'Minimum order': 'מינימום הזמנה',
          'units per': 'כמות',
          'Home': 'בית',
          'Favorites': 'מועדפים',
          'Order': 'הזמנות',
          'Catalog': 'קטלוג',
          'Brands': 'מותגים',
          'Families': 'משפחות',
          'We will update as soon as it returns to stock': 'נעדכן חוזר למלאי',
          'Not in stock, update when he gets back?': 'לא במלאי, לעדכן כשיחזור?',
          'Alternative product': 'למוצר  חלופי',
          'Back to original product': 'חזרה למוצר המקורי',
          'free pallets added!': 'התווספו לך  משטחים חינם !',
          'This product was partially supplied, supplied': 'מוצר זה סופק באופן',
          'Supplied!': 'סופק!',
          'Here will come an error message': 'פה תבוא הודעת שגיאה ',
          'You may be\nmissing!': "יתכן שחסר \nאצלך!",
          'Zero': 'אפס',
          'Unit': 'יח׳',
          'Inner': 'Inner',
          'Carton': 'משטח',
          'Palete': 'קרטון',
          'units in': 'יח׳',
          'More results': 'עוד תוצאות',
          'Code': 'מק"ט',
          'Barcode': 'ברקוד',
          'About the product': 'על המוצר',
          'The Rabbinical Society': 'בד״צ אגוד הרבנים',
          'Shop': 'קנו',
          'Get': 'קבלו',
          'Substitutes for this product': 'תחליפים למוצר זה',
          'Password condition':
              'הסיסמא צריכה להכיל לפחות 8 תווים אות 1 גדולה אות 1 קטנה מספר ותוו מיוחד',
          'Current': 'נוכחי',
          'Password display in asterisks': 'הסיסמא מוצגת בכוכביות',
          'For details please contact the hotline':
              'לפרטים נא להתקשר לקוו החם שלנו',
          'Passwords must not match': 'הסיסמאות צריכות להיות שונות אחת מהשניה',
          'New password is not match': 'הסיסמא החדשה אינה תואמת',
          'password is empty': 'הסיסמא ריקה',
          'Cancellation': 'ביטול',
          'Add the entire list to cart': 'הוספת כל הרשימה לסל',
          'Sorting': 'מיון',
          'Belongs on the list': 'שייך לרשימה',
          'Remove from favorites': 'הסרה מהמועדפים',
          'No product transfer yet To this list':
              'עדיין לא העברת מוצרים \nלרשימה זו',
          'Save your products on the page Favorites by clicking on -':
              'שומרים את המוצרים בעמוד\nהמועדפים באמצעות לחיצה על -',
          'On the favorites page, click on -': 'בעמוד המועדפים, לחיצה על -',
          'Let you move the product To one of the lists you opened':
              'תאפשר\n לך להעביר את המוצר\לאחת מהרשימות שפתחת',
          'Delete the list': 'מחיקת\n הרשימה ',
          'New shopping list': 'רשימת קניות חדשה',
          'List Name': 'שם הרשימה',
          "Good, you've made a new list!": "יופי, יצרתם רשימה חדשה!",
          'To fill out the list click on the three points on the left side of the product':
              'כדי\n למלא את הרשימה לחצו על השלוש נקודות בצד שמאל של המוצר',
          'Shopping cart': 'סל קניות',
          'Your shopping cart is empty': 'סל הקניות שלך ריק',
          'To start an order from the recommended list':
              'לתחילת הזמנה מהרשימה המומלצת',
          'Emptying All Basket': 'כל הסל\n כל הסל',
          'Save As a shopping list': ' שמירהכרשימת\n קניות',
          'Add Products From the catalog': 'מהקטלוג\n הוספת מוצרים',
          'Saving as a shopping list': 'שמירה כרשימת קניות',
          'The list will be kept in the preferred area':
              'הרשימה תשמר באזור המועדפים',
          'Search branch': 'חיפוש סניף',
          'Our focus is open': 'מוקד שרות לקוחות',
          'All brunches': 'כל הסניפים',
          'Terms of Use': 'תנאי שימוש',
          'Close': 'סגור',
          'No materials': 'אין חומרים',
          'Filtering': 'סִנוּן',
          'Filter by': 'סנן לפי',
          'Not implemented': 'לא מיושם',
          'Materials loading error': 'שגיאת טעינת חומרים',
          'Favorites loading error': 'שגיאת טעינת מועדפים',
          'All branches': 'כל הסניפים',
          'Recomended List': 'רשימה מומלצת',
          'Client ID': 'מזהה לקוח:',
          'Last order date': 'תאריך הזמנה אחרון:',
          'Distance': 'מֶרְחָק:',
        }
      };
}
