import 'package:angular2/core.dart';

@Injectable()
class PhraseService
{
  PhraseService();

  String get(String key, {Map<String, String> params : null, bool capitalize_first : true})
  {
    if (key == null) return null;
    if (key.isEmpty) return "";
    String phrase = (_phraseData.containsKey(key)) ? _phraseData[key] : key;
    if (capitalize_first) phrase = phrase[0].toUpperCase() + phrase.substring(1, phrase.length);

    if (params != null)
    {
      params.forEach((key, value)
      {
        phrase = phrase.replaceAll("%$key%", value);
      });
    }

    return phrase;
  }

  String get_multiple(List<String> phrase_keys, { Map<String, String> params : null, String separator : " ", bool capitalize_first : true})
  {
    List<String> phraseValues = new List();
    for (String key in phrase_keys)
    {
      if (_phraseData.containsKey(key)) phraseValues.add(_phraseData[key]);
      else phraseValues.add(key);
    }
    String phrase = phraseValues.join(separator);
    if (capitalize_first) phrase = phrase[0].toUpperCase() + phrase.substring(1, phrase.length);

    return phrase;
  }

  final Map<String, String> _phraseData =
  {
    "account" : "konto",
    "action" : "aktivitet",
    "action_plural" : "aktiviteter",
    "active" : "aktiv",
    "add" : "lägg till",
    "add_many" : "lägg till flera",
    "add_action" : "lägg till aktivitet",
    "administration" : "administration",
    "after_first_view" : "efter första visning",
    "back" : "tillbaka",
    "back_to_editing" : "tillbaka till redigeringen",
    "cancel" : "avbryt",
    "change_day" : "byt dag",
    "change_time" : "byt tid",
    "choose_at_least_one" : "välj minst ett",
    "color_highlight" : "highlight",
    "color_plural" : "färger",
    "color_primary" : "primär",
    "color_secondary" : "sekundär",
    "confirm" : "bekräfta",
    "confirm_continue" : "ja, fortsätt",
    "confirm_email_sms_valid" : "Dubbelkolla att mejladressen och/eller mobilnumret stämmer:",
    "confirm_email_sms_valid_no_values" : "Du har inte angett mejladdress/mobilnummer, användaren kommer inte att få några inloggningsuppgifter skickade till sig. Är du säker på att du vill fortsätta?",
    "connected_plural" : "anslutna",
    "contact_information" : "kontaktinformation",
    "content" : "innehåll",
    "content_title" : "innehållstitel",
    "content_type" : "innehållstyp",
    "course" : "plan",
    "course_plural" : "planer",
    "csv_tooltip" : "Semi-kolon mellan varje värde och radbryt mellan varje användare - mejl@mejl.com;070xxxxxxx;förnamn;efternamn",
    "custom" : "anpassad",
    "day" : "dag",
    "days_to_first_day" : "antal dagar från första dagen på jobbet",
    "delete" : "radera",
    "description" : "beskrivning",
    "design" : "design",
    "details" : "uppgifter",
    "download_template" : "hämta mall",
    "edit" : "redigera",
    "edit_action" : "redigera aktivitet",
    "edit_action_on_timeline" : "redigera aktivitet på tidslinjen",
    "email" : "mejl",
    "email_notification_sent" : "mejl-notifikation skickad",
    "embed" : "inbäddad",
    "embedded" : "inbäddad",
    "error_occurred" : "ett fel inträffade",
    "error_unique_action_name" : "det finns redan en aktivitet med detta namn",
    "error_unique_email" : "det finns redan en användare med denna mejl",
    "error_unique_learning_content_name" : "det finns redan ett lärinnehåll med detta namn",
    "error_unique_phone" : "det finns redan en användare med detta telefonnummer",
    "error_unique_push_notification_name" : "det finns redan ett utskick med detta namn",
    "error_unique_username" : "det finns redan en användare med detta användarnamn",
    "external_url" : "extern URL",
    "failed" : "misslyckades",
    "file" : "fil",
    "filename" : "filnamn",
    "file_manager" : "filhanterare",
    "file_plural" : "filer",
    "firstname" : "förnamn",
    "first_day_at_work" : "första dagen",
    "footer_learning_content" : "Lärinnehåll i sidfot",
    "footer_learning_content_description" : "Välj vilket lärinnehåll i biblioteket som ska visas i sidfoten.",
    "forgot_password" : "glömt lösenord",
    "forgot_password_description" : "Skriv in ditt användarnamn för att återställa ditt lösenord.",
    "frontpage" : "portal",
    "frontpage_design" : "portaldesign",
    "icon" : "ikon",
    "image_plural" : "bilder",
    "in_library" : "i bibliotek",
    "include_inactive" : "inkludera inaktiva",
    "information" : "information",
    "invalid_details" : "felaktigt användarnamn eller lösenord",
    "invalid_email" : "felaktig e-post",
    "invalid_phone" : "felaktigt mobilnummer",
    "invalid_url" : "Ange en giltig URL (inklusive http)",
    "invalid_youtube_id" : "Ange ett giltigt youtube video id (11 tecken)",
    "key" : "nyckel",
    "lastname" : "efternamn",
    "learning_content" : "lärinnehåll",
    "learning_content_plural" : "lärinnehåll",
    "library_learning_contents" : "lärinnehåll i bibliotek",
    "list" : "lista",
    "location" : "plats",
    "login" : "logga in",
    "logout" : "logga ut",
    "logotype" : "logotyp",
    "max_filesize_exceeded" : "den maximala filstorleken har överskridits",
    "menu" : "meny",
    "message" : "meddelande",
    "name" : "namn",
    "new_password" : "nytt lösenord",
    "next" : "nästa",
    "no_actions_found" : "Inga aktiviteter funna",
    "no_learning_contents_found" : "Inga lärinnehåll funna",
    "no_courses_found" : "Inga planer funna",
    "no_push_notifications_found" : "Inga utskick funna",
    "no_users_found" : "Inga användare funna",
    "none" : "ingen",
    "notify_email" : "skicka mejl",
    "notify_sms" : "skicka SMS",
    "page" : "sida",
    "password" : "lösenord",
    "phone" : "mobilnummer",
    "phrase_plural" : "texter",
    "previous" : "föregående",
    "push_notification" : "utskick",
    "push_notification_plural" : "utskick",
    "push_notification_not_qualified" : "Fyll i mobilnummer eller mejl för att göra utskick",
    "push_sms" : "push-SMS",
    "recover_password" : "Återställning lösenord introduktion.nu",
    "recover_password_message" : "<h1 style='text-align:center'>Hej!</h1><p style='text-align:center'>För att uppdatera ditt lösenord på introduktion.nu, använd följande återställningsnyckel: <strong>%token%</strong></p><p style='text-align:center; font-size:0.9em;'>Om du inte begärt att återställa ditt lösenord kan du ignorera detta meddelande.</p>",
    "remove" : "ta bort",
    "remove_from_timeline" : "ta bort från tidslinjen",
    "reset_password" : "återställ lösenord",
    "reset_password_description" : "Vi har skickat ett mejl till dig med en återställningsnyckel, klistra in den nedan för att uppdatera ditt lösenord.",
    "result" : "resultat",
    "save" : "spara",
    "select" : "välj",
    "select_time" : "välj tid",
    "send" : "skicka",
    "send_voucher" : "skicka glassogram-sms efter första videon",
    "settings" : "inställningar",
    "settings_saved" : "ändringarna har sparats",
    "sms_notification_sent" : "SMS-notifikation skickad",
    "social_media" : "sociala medier",
    "start_date" : "startdatum",
    "start_videos" : "startfilmer",
    "start_videos_description" : "Välj vilket lärinnehåll som ska visas längs upp på framsidan, i turordning.",
    "subject" : "ämnestitel",
    "success" : "lyckades",
    "theme" : "tema",
    "time" : "klockan",
    "timeline" : "tidslinje",
    "timeline_actions" : "aktiviteter på tidslinjen",
    "timeline_background" : "bakgrund tidslinje",
    "undo" : "ångra",
    "update" : "uppdatera",
    "update_connected_users" : "uppdatera anslutna användare",
    "upload" : "ladda upp",
    "url" : "URL",
    "user" : "användare",
    "user_management" : "användarhantering",
    "user_not_found" : "kunde inte hitta någon med detta användarnamn",
    "user_has_been_notified" : "användaren fick en inbjudan",
    "user_has_not_been_notified" : "användaren har inte fått någon inbjudan",
    "user_with_email_already_exists" : "det finns redan en användare med epost: %email%",
    "user_with_username_already_exists" : "det finns redan en användare med användarnamn: %username%",
    "user_with_phone_already_exists" : "det finns redan en användare med telefonnummer: %phone%",
    "username" : "användarnamn",
    "user_plural" : "användare",
    "welcome_message" : "inbjudan",
    "Exception: User Already Registered (http status: 409)" : "Det finns redan en användare med detta användarnamn.",
    "Exception: file_error_413" : "Ett fel inträffade: Filen är för stor! (max 1mb)",
    "Exception: mysqli_error_1451" : "Operationen kunde inte genomföras eftersom objektet är skrivskyddat.",
    "Exception: mysqli_error_1062" : "Kunde inte spara objektet på grund av en unik restriktion i databasen.",
  };
}